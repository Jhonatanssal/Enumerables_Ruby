module Enumerable
  def my_each
    self.to_a
    e = self.size - 1
    return unless block_given?

    0.upto(e) do |x|
      yield(self[x])
    end
    self
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
    self.to_a
    e = self.size - 1
    arr = []
    if block_given?
      0.upto(e) do |x|
        if yield(self[x]) arr.push(self[x])
      end
    end
    arr
  end

  def my_all?
    self.to_a
    e = self.size - 1

    if block_given?
      0.upto(e) do |x|
        unless yield(self[x]) return false
      end
    end
    true
  end

  def my_any?
    self.to_a
    e = self.size - 1

    if block_given?
      0.upto(e) do |x|
        if yield(self[x]) return true
      end
    end
    false
  end

  def my_none?
    self.to_a
    e = self.size - 1

    if block_given?
      0.upto(e) do |x|
        if yield(self[x]) return false
      end
    end
    true
  end

  def my_count(input = nil)
    self.to_a
    count = 0

    if block_given?
      self.my_each do |x|
        if yield(x) count += 1
      end
      count
    end
    
    if input.nil? return self.length

    self.my_each do |x|
      if x == input { count += 1 }
    end
    count
  end

  def my_map
    var = self.to_a
    arr = []
    var.my_each do |x|
      arr.push(yield(x))
    end
    arr
  end

  def my_inject(*arg)
    var = self.to_a
    b = var.size - 1

    if block_given?
      if arg.empty?
        acc = var[0]
        1.upto(b) do |i|
          acc = yield(acc, var[i])
        end
        acc
      elsif arg.size == 1
        acc = arg[0]
        0.upto(b) do |i|
          acc = yield(acc, var[i])
        end
        acc
      end
    elsif arg.size == 1
      acc = var[0]
      1.upto(b) do |i|
        acc = acc.send(arg[0], var[i])
      end
      acc
    elsif arg.size == 2
      acc = arg[0]
      0.upto(b) do |i|
        acc = acc.send(arg[1], var[i])
      end
      acc
    end
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

print multiply_els([2, 4, 5])
puts
