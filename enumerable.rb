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
        arr.push(var[x]) if yield(var[x])
      end
    end
    arr
  end

  def equl_type(arg, input)
    return arg.is_a?(input) if input.is_a?(Class)
    return arg.match(input) if input.is_a?(Regexp)

    arg == input
  end

  def my_all?(input = nil)
    var = to_a
    e = size - 1

    if block_given?
      0.upto(e) do |x|
        return false unless yield(var[x])
      end
    elsif !input.nil?
      0.upto(e) do |x|
        return false unless equl_type(var[x], input)
      end
    else
      0.upto(e) do |x|
        return false unless var[x]
      end
    end
    true
  end

  def my_any?(input = nil)
    var = to_a
    e = size - 1

    if block_given?
      0.upto(e) do |x|
        return true if yield(var[x])
      end
    elsif !input.nil?
      0.upto(e) do |x|
        return true if equl_type(var[x], input)
      end
    else
      0.upto(e) do |x|
        return true if var[x]
      end
    end
    false
  end

  def my_none?(input = nil)
    var = to_a
    e = size - 1

    if block_given?
      0.upto(e) do |x|
        return false if yield(var[x])
      end
    elsif !input.nil?
      0.upto(e) do |x|
        return false if equl_type(var[x], input)
      end
    else
      0.upto(e) do |x|
        return false if var[x]
      end
    end
    true
  end
end

module Enumerable
  def my_count(input = nil)
    var = to_a
    count = 0

    if block_given?
      var.my_each do |x|
        count += 1 if yield(x)
      end
      return count
    end
    return var.length if input.nil?

    var.my_each do |x|
      count += 1 if x == input
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
    else
      var.my_each do |x|
        arr.push(proc[x]) if proc.is_a?(Proc)
      end
    end
    arr
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
