module PaLearner

  class DistRegressor
    def initialize( n, eps=0.001)
      @w   = Array.new(n, 0)
      @eps = eps
    end

    def estimate(x)
      inner_product( x, @w)
    end

    def update!(x,y)
      rate = sign( estimate(x) - y ) * learn_rate(x, y)
      rate_x = x.map {|v| -Math::log(v) * rate }
      @w = @w.zip( rate_x ).map{ |v| v.first + v.last }
      project_to_simplex!(@w)
      "updated"
    end

    #------
    private

    def learn_rate( x, y )
      norm_x = inner_product(x, x)
      loss( estimate(x), y) / (norm_x == 0 ? 0.00001 : norm_x)
    end

    def inner_product(a, b)
      a.zip(b).map {|v| v.first*v.last}.inject(0){|sum,v| sum+v }
    end

    def loss(y_e, y)
      [ 0, (y_e - y).abs - @eps ].max
    end

    def sign( v )
      v >=0 ? 1 : -1
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

end

