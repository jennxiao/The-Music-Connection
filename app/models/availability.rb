# frozen_string_literal: true

class Availability
  attr_reader :weekday, :start_time, :end_time

  def initialize(weekday, start_time, end_time)
    @weekday = weekday
    @start_time = Time.parse('Thu Jan 1 ' + start_time + ' 1970')
    @end_time = Time.parse('Thu Jan 1 ' + end_time + ' 1970')
  end

  class << self
    def serialize(a)
      a.weekday + '&' + a.start_time.to_s + '&' + a.end_time.to_s + ';'
    end

    def deserialize(a)
      ret = []
      sp = a.split(';')
      sp.each do |astr|
        akek = astr.split('&')
        ret.push(Availability.new(akek[0], akek[1], akek[2]))
      end
      ret
    end

    def overlap(a, b)
      a, b = b, a if b.start_time < a.start_time
      # a starts and ends before b begins
      return 0 if a.end_time < b.start_time
      # a starts before b starts
      # a ends after b ends
      return b.end_time - b.start_time if a.end_time > b.end_time
      # regular case overlap
      a.end_time - b.start_time
    end
  end
end
