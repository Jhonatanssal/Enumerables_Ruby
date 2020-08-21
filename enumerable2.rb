module Enumerable
  def my_each
    return unless block_given?
    var = to_a
    e = size - 1
    0.upto(e) do |x|
      yield(var[x])
    end
    var
  end

  def my_each_with_index
    self.to_a
    e = self.size - 1
    return unless block_given?
    0.upto(e) do |x|
      yield(self[x], x)
    end
    self
  end

  def my_select
    var = self.to_a
    e = var.size - 1
    arr = []
    if block_given?
      0.upto(e) do |x|
        if yield(var[x]) then arr.push(var[x]) end
      end
    end
    arr
  end

end

=begin var = [1,2,3,4,5].my_select { |num|  num.even?  }
print var
=end

var = %w[ant bear cat].my_all?(/d/) 
print var