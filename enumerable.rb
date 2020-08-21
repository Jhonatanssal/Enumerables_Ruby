module Enumerable
  def my_each
    var = to_a
    e = size - 1
    return unless block_given?

    0.upto(e) do |x|
      yield(var[x])
    end
    var
  end

  def my_each_with_index
    var = to_a
    e = size - 1
    return unless block_given?
    
    0.upto(e) do |x|
      yield(var[x], x)
    end
    var
  end

  def my_select
    var = to_a
    e = size - 1
    arr = []
    if block_given?
      0.upto(e) do |x|
        if yield(var[x]) then arr.push(var[x]) end
      end
    end
    arr
  end

  def my_all?(input = nil)
    var = to_a
    e = size - 1

    if block_given?
      0.upto(e) do |x|
        unless yield(var[x]) then return false end
      end
    elsif !input.nil?
      0.upto(e) do |x|
        unless input === var[x] then return false end
      end
    else
      0.upto(e) do |x|
        unless var[x] then return false end
      end
    end
    true
  end

  def my_any?(input = nil)
    var = to_a
    e = size - 1

    if block_given?
      0.upto(e) do |x|
        if yield(var[x]) then return true end
      end
    elsif !input.nil?
      0.upto(e) do |x|
        if input === var[x] then return true end
      end
    else
      0.upto(e) do |x|
        if var[x] then return true end
      end
    end
    false
  end

  def my_none?(input = nil)
    var = to_a
    e = size - 1

    if block_given?
      0.upto(e) do |x|
        if yield(var[x]) then return false end
      end
    elsif !input.nil?
      0.upto(e) do |x|
        if input === var[x] then return false end
      end
    else
      0.upto(e) do |x|
        if var[x] then return false end
      end
    end
    true
  end

  def my_count(input = nil)
    var = to_a
    count = 0

    if block_given?
      var.my_each do |x|
        if yield(x) then count += 1 end
      end
      count
    end
    
    if input.nil? then var.length end

    var.my_each do |x|
      if x == input then count += 1 end
    end
    count
  end

  def my_map(proc = nil)
    var = to_a
    arr = []

    if block_given?
      var.my_each do |x|
        arr.push(yield(x))
      end
      arr
    else
      var.my_each do |x|
        arr.push(proc[x]) if proc.is_a?(Proc)
      end
      arr
    end
  end

  def my_inject(*arg)
    var = to_a
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

var = [1, 3.14, 42].my_none?(Float)
print var
