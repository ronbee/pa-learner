module PaLearner
  EPS_TO_AVOID_ZERO_DIV = 0.000000001
  attr :w
  
  def estimate(x)
    inner_product( x, @w)
  end
  
  def bin_classify(x)
    sign( estimate(x) )
  end
  
  class PA
    include PaLearner
    
    def initialize(n, type=:pa, cost = 0)
      pa_kickstart( n )
      @type = type
      @cost = cost
      self
    end
    
    def update!(x, y)
      l = hinge_loss( x, y )
      etta = calc_update_delta( l, x)
      @w.each_index { |i| @w[i] += y*etta*x[i] }
      self
    end
    
    private
    def calc_update_delta(l,x)
      delta = l / ( inner_product( x, x ) + EPS_TO_AVOID_ZERO_DIV )  if @type == :pa
      delta = [ @cost, l / ( inner_product( x, x ) + EPS_TO_AVOID_ZERO_DIV ) ].min if @type == :pa_I
      delta = l / ( inner_product( x, x ) + 1/(2+@cost) ) if @type == :pa_II
      delta
    end
  end
  
  class DistRegressor
    include PaLearner
    def initialize( n, eps=0.001)
      pa_kickstart( n )
      @eps = eps
    end

    def update!(x,y)
      rate = sign( estimate(x) - y ) * (   loss( estimate(x), y ) / ( inner_product(x, x) + EPS_TO_AVOID_ZERO_DIV )   ) 
      rate_x = x.map {|v| -Math::log(v) * rate }
      @w = @w.zip( rate_x ).map{ |v| v.first + v.last }
      project_to_simplex!(@w)
      self
    end

    #------
    private

    def loss(y_e, y)
      [ 0, (y_e - y).abs - @eps ].max
    end    

    def project_to_simplex!( w )
      working_ind = w.inject( {} ){|m,v| m[m.size]=v; m }.keys
      last_size = working_ind.size + 1
      while working_ind.size < last_size && working_ind.size > 0
        last_size = working_ind.size
        update = (working_ind.inject(0){|s,i| s+w[i]} -1) / working_ind.size.to_f
        working_ind.reject! do |i|
          w[i] -= update
          w[i] = 0 if w[i] < 0
          w[i] == 0
        end
      end
      w
    end
  end
  
  #------
  private

  def pa_kickstart(n)
    @w   = Array.new(n, 0)
  end

  def inner_product(a, b)
    a.zip(b).map {|v| v.first*v.last}.inject(0){|sum,v| sum+v }
  end

  def hinge_loss(x,y)
    [0, 1 - inner_product(@w, x) * y].max
  end

  def sign( v )
    v >=0 ? 1 : -1
  end

end

