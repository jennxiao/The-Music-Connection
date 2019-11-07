class Availability
  attr_reader :weekday, :start_time, :end_time

  def initialize(weekday, start_time, end_time)
    @weekday = weekday
    @start_time = Time.parse("Thu Jan 1 " + start_time + " 1970")
    @end_time = Time.parse("Thu Jan 1 " + end_time + " 1970")
  end
  
  class << self
    def serialize(a)
      a.weekday + "&" + a.start_time.to_s + "&" + a.end_time.to_s + ";"
    end
    def deserialize(a)
      ret = []
      sp = a.split(';')
      sp.each do |astr|
        akek = astr.split("&")
        ret.push(Availability.new(akek[0], akek[1], akek[2]))
      end
      return ret
    end
    def overlap(a, b)
      if b.start_time < a.start_time
        a, b = b, a
      end
      # a starts and ends before b begins
      if a.end_time < b.start_time
        return 0
      end
      # a starts before b starts
      # a ends after b ends
      if a.end_time > b.end_time
        return b.end_time - b.start_time
      end
      # regular case overlap
      return a.end_time - b.start_time
    end
  end
end
