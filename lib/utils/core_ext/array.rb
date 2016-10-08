#
#
#

class Array
  #
  #
  #
  def random_choice
    self[rand(length)]
  end

  #
  #
  #
  def map_with_index
    map = []
    each_with_index do |ix, e|
      map << yield(ix, e)
    end
    map
  end
  
  class << self
    #
    #
    #
    def consists(n, elem)
      n.times.map { elem }
    end

    #
    #
    #
    def sequence(first, last=nil, step=nil)
      unless last
        last = first - 1
        first = 0
      end
      unless step
        step = 1
      end
      list = []
      n = first
      if step > 0
        while n <= last
          list << n
          n += step
        end
      elsif step < 0
        while n >= last
          list << n
          n += step
        end
      end
      list
    end
  end
end
