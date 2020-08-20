module Enumerable
  def my_each
    e = self.length - 1
    if block_given?
      0.upto(e) do |x|
        yield(self[x])
      end
    end
  end

  def my_each_with_index
    e = self.length - 1
    if block_given?
      0.upto(e) do |x|
        yield(self[x],x)
      end
    end
  end
end

%w(Ibrahimovic is better than Messi).my_each_with_index {|i,j| puts i+ " ====> "+ j.to_s}