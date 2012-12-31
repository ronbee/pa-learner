require 'minitest/unit'
 
# using guard 
require File.dirname(__FILE__) + '/../lib/pa_learner'
require File.dirname(__FILE__) + '/../lib/sparse_vs'

class MatchTest < MiniTest::Unit::TestCase

  def setup
    d = [0.25, 0.75] # ground truth -- we will use it for testing both distribution tracking, and classification
    @data = Array.new(100)
    (0..@data.size).each do |i|
      x_1 = rand
      x_2 = 1 - x_1
      @data[i] = {:y=>d[0]*x_1+d[1]*x_2 , :x=>[x_1, x_2]}
    end        
  end

  def test_sanity_distribution_tracking
    pal = PaLearner::DistRegressor.new( 2 )

    @data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]); pal; }
    @data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]); pal; }

    puts "pal.estimate([1,0]) = #{pal.estimate( [1, 0] )}"
    puts "pal.estimate([0,1]) = #{pal.estimate( [0, 1] )}"

    assert( ( (pal.estimate( [1, 0] )-0.25).abs - 0.01) < 0, "epsilon error larger than 0.01" )
  end
  
  def test_sanity_classify_pa_0
    pal = PaLearner::PA.new( 2 )
    @data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]>=0 ? 1 : -1); pal; }
    err_rate = ( @data.inject(0) {|errs,yx| errs += 1 unless pal.bin_classify(yx[:x]) == (yx[:y]>=0 ? 1 : -1); errs } ) / @data.size.to_f
    assert( err_rate < 0.0001, "PA-0 error rate is too high: #{err_rate}" )
  end
  
  def test_sanity_classify_pa_I
    pal = PaLearner::PA.new( 2, :pa_I, 10 )
    @data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]>=0 ? 1 : -1); pal; }
    err_rate = ( @data.inject(0) {|errs,yx| errs += 1 unless pal.bin_classify(yx[:x]) == (yx[:y]>=0 ? 1 : -1); errs } ) / @data.size.to_f
    assert( err_rate < 0.0001, "PA-I error rate is too high: #{err_rate}" )
  end
  
  def test_sanity_classify_pa_II
    pal = PaLearner::PA.new( 2, :pa_II, 10 )
    @data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]>=0 ? 1 : -1); pal; }
    err_rate = ( @data.inject(0) {|errs,yx| errs += 1 unless pal.bin_classify(yx[:x]) == (yx[:y]>=0 ? 1 : -1); errs } ) / @data.size.to_f
    assert( err_rate < 0.0001, "PA-II error rate is too high: #{err_rate}" )
  end

  def test_sprase_vs_basic
    x1 = PaLearner::SparseVect.new( { "1" => 1, "2" => 2, "4" => 4} )
  end

end
