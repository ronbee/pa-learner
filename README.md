#The what?
Online learning algorithm: Lightweight, that-works
 
Implementation of a ``Passive-Aggressive'' online learning algorithm. The Passive-Aggressive online learning framework defines a family of online margin based linear learners. For further details see: 'Online Passive-Aggressive Algorithms' by Crammer et al. JMLR, 2006.
- - - 
#The how?

##Usage
>x is a vector (Array) of dim elements
>y is its corresponding value (label -or- functional value)
###Init
>pal = PaLearner::DistRegressor.new( dim )
###Update
>pal.update!(x, y)
###Estimate
>pal.estimate( x ) 

##Examples
>d = [0.25, 0.75]
>@data = Array.new(100)
>(0..@data.size).each do |i|
>  x_1 = rand
>  x_2 = 1 - x_1
>  @data[i] = {:y=>d[0]*x_1+d[1]*x_2 , :x=>[x_1, x_2]}
>end
>puts "data--size = #{@data.size}"
>
>pal = PaLearner::DistRegressor.new( 2 )
>
>@data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]); pal; }
>@data.shuffle.inject(pal) { |pal, yx| pal.update!(yx[:x], yx[:y]); pal; }
>
>puts "pal.estimate([1,0]) = #{pal.estimate( [1, 0] )}"
>puts "pal.estimate([0,1]) = #{pal.estimate( [0, 1] )}"

#License
##The MIT License
``
Copyright (c) 2010 ronbee.github@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.''