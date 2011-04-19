require 'minitest/unit'

require File.dirname(__FILE__) + '/../lib/pa_learner'

class MatchTest < MiniTest::Unit::TestCase

  def setup
    d = [0.25, 0.75]
    @data = Array.new(100)
    (0..@data.size).each do |i|
      x_1 = rand
      x_2 = 1 - x_1
      @data[i] = {:y=>d[0]*x_1+d[1]*x_2 , :x=>[x_1, x_2]}
    end
    puts "data--size = #{@data.size}"




  end

  def test_sanity
    pal = PaLearner::DistRegressor.new( 2 )

    @data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]); pal; }
    @data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]); pal; }

    puts "pal.estimate([1,0]) = #{pal.estimate( [1, 0] )}"
    puts "pal.estimate([0,1]) = #{pal.estimate( [0, 1] )}"

    assert( ( (pal.estimate( [1, 0] )-0.25).abs - 0.01) < 0, "epsilon error larger than 0.01" )
  end

end
