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

  def my_all?
    var = self.to_a
    e = var.size - 1
    
    if block_given?
      0.upto(e) do |x|
        unless yield(var[x])
          return false
        end
      end
    end
    return true
  end

  def my_any?
    var = self.to_a
    e = var.size - 1
    
    if block_given?
      0.upto(e) do |x|
        if yield(var[x])
          return true
        end
      end
    end
    return false
  end

  def my_none?
    var = self.to_a
    e = var.size - 1
    
    if block_given?
      0.upto(e) do |x|
        if yield(var[x])
          return false
        end
      end
    end
    return true
  end

end

puts %w{ant bear cat ibrahimovic}.my_none? { |word| word.length >= 5 }