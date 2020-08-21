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

  def my_all?
    self.to_a
    e = self.size - 1

    if block_given?
      0.upto(e) do |x|
        unless yield(self[x]) then false end
      end
    end
    true
  end

  def my_any?
    self.to_a
    e = self.size - 1

    if block_given?
      0.upto(e) do |x|
        if yield(self[x]) then true end
      end
    end
    false
  end

  def my_none?
    self.to_a
    e = self.size - 1

    if block_given?
      0.upto(e) do |x|
        if yield(self[x]) then false end
      end
    end
    true
  end

  def my_count(input = nil)
    self.to_a
    count = 0

    if block_given?
      self.my_each do |x|
        if yield(x) then count += 1 end
      end
      count
    end
    
    if input.nil? then self.length end

    self.my_each do |x|
      if x == input then count += 1 end
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

var = (1..10).my_select { |i|  i % 3 == 0 }
print var