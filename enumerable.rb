module Enumerable
  def my_each
    e = self.length - 1
    if block_given?
      0.upto(e) do |x|
        yield(self[x])
      end
    end
  end

end