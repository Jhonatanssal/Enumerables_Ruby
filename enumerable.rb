module Enumerable
  def my_each
    var = self.to_a
    e = var.size - 1
    if block_given?
      0.upto(e) do |x|
        yield(var[x])
      end
    end
  end

  def my_each_with_index
    var = self.to_a
    e = var.size - 1
    if block_given?
      0.upto(e) do |x|
        yield(var[x],x)
      end
    end
  end

  def my_select
    var = self.to_a
    e = var.size - 1
    arr = []
    if block_given?
      0.upto(e) do |x|
        if yield(var[x])
          arr.push(var[x])
        end
      end
    end
    return arr
  end

end

