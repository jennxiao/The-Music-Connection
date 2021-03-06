# frozen_string_literal: true

# Shared helper methods for processing form input
module FormHelper
  extend ActiveSupport::Concern

  def convert_to_boolean(res, pos = 'yes')
    return false if res.nil?

    res.strip.downcase == pos
  end

  def serialize_array_output(arr)
    str = ''
    (0...arr.count).each do |i|
      str += (arr[i].to_s + ',')
    end
    str.chomp!(',')
    str
  end

  def serialize_instruments(instr, other)
    str = ''
    j = 0
    (0...instr.count).each do |i|
      if instr[i] == 'Other'
        str += (other[j].gsub(/[^a-zA-Z]/, '') + ',')
        j += 1
      else
        str += (instr[i] + ',')
      end
    end
    str.chomp(',')
  end

  def serialize_availabilities(day, start_time, end_time)
    str = ''
    (0...day.count).each do |i|
      a = Availability.new(day[i], start_time[i], end_time[i])
      str += Availability.serialize(a)
    end
    str
  end
end
