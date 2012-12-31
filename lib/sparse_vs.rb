require 'json'

module PaLearner
  
  class SparseVect
	def initialize v_as_hash
		@v = v_as_hash
    	end

	def cord id
		@v[id]
	end

	def inner_prod x
		(@v.keys - (v.keys - x.v.keys) ).inject(0.0){|agg,k| agg += @v[k]*x[k]} 
	end

	def each &block
		@v.keys.each &block
	end
  
	def to_json
		@v.to_json
	end

	def to_s
		to_json
	end
  end


end


