module Enumerable
  def my_each
    self.to_a
    e = self.size - 1
    if block_given?
      0.upto(e) do |x|
        yield(self[x])
      end
      self
    end
  end

  def my_each_with_index
    self.to_a
    e = self.size - 1
    if block_given?
      0.upto(e) do |x|
        yield(self[x],x)
      end
      self
    end
  end

  def my_select
    self.to_a
    e = self.size - 1
    arr = []
    if block_given?
      0.upto(e) do |x|
        if yield(self[x])
          arr.push(self[x])
        end
      end
    end
    return arr
  end

  def my_all?
    self.to_a
    e = self.size - 1
    
    if block_given?
      0.upto(e) do |x|
        unless yield(self[x])
          return false
        end
      end
    end
    return true
  end

  def my_any?
    self.to_a
    e = self.size - 1
    
    if block_given?
      0.upto(e) do |x|
        if yield(self[x])
          return true
        end
      end
    end
    return false
  end

  def my_none?
    self.to_a
    e = self.size - 1
    
    if block_given?
      0.upto(e) do |x|
        if yield(self[x])
          return false
        end
      end
    end
    return true
  end

  def my_count(input = nil)
    self.to_a
    count = 0
    
    if block_given?
      self.my_each do |x|
        if yield(x)
          count += 1 
        end
      end
      count
    end
    
    if input.nil?
      return self.length
    end

    self.my_each do |x| 
      if x == input
        count += 1
      end
    end
    count 

  end

  def my_map(proc = nil)
    self.to_a
    arr = []

    if block_given?
      self.my_each do |x|
        arr.push(yield(x))
      end
      return arr
    else
      self.my_each do |x|
        arr.push(proc[x]) if proc.is_a?(Proc)
      end
      return arr
    end
  end

  def my_inject(*arg)
    self.to_a
    b = var.size - 1

    if block_given?
      if arg.empty?
        acc = var[0]
        1.upto(b) do |i|
          acc = yield(acc, self[i])
        end
        acc
      elsif arg.size == 1
        acc = arg[0]
        0.upto(b) do |i|
          acc = yield(acc, self[i])
        end
        acc
      end
    elsif arg.size == 1
      acc = self[0]
      1.upto(b) do |i|
        acc = acc.send(arg[0], self[i])
      end
      acc
    elsif arg.size == 2
      acc = arg[0]
      0.upto(b) do |i|
        acc = acc.send(arg[1], self[i])
      end
      acc
    end
  end
end

print [2,4,5].my_each_with_index {|x| x * 2}