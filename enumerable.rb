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

  def my_count(input = nil)
    var = self.to_a
    count = 0
    
    if block_given?
      var.my_each do |x|
        if yield(x)
          count += 1 
        end
      end
      count
    end
    
    if input.nil?
      return var.length
    end

    var.my_each do |x| 
      if x == input
        count += 1
      end
    end
    count 

  end

  def my_map
    var = self.to_a
    arr = []
    var.my_each do |x|
      arr.push(yield(x))
    end
    return arr
  end

  def my_inject(*arg)
    var = self.to_a
    b = var.size - 1

    if block_given?
      if arg.size == 0
        acc = var[0]
        1.upto(b) do |i|
          acc = yield(acc, var[i])
        end
        return acc
      elsif arg.size == 1
        acc = arg[0]
        0.upto(b) do |i|
          acc = yield(acc, var[i])
        end
        return acc
      end
    else
      if arg.size == 1
        acc = var[0]
        1.upto(b) do |i|
          acc = acc.send(arg[0],var[i])
        end
        return acc
      elsif arg.size == 2
        acc = arg[0]
        0.upto(b) do |i|
          acc = acc.send(arg[1],var[i])
        end
        return acc
      end
    end
  end

end

