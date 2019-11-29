module FormHelper
  extend ActiveSupport::Concern

  def convert_to_boolean(r, p="yes")
    if r.nil?
      return false
    end
    return r.strip.downcase == p
  end

  def serialize_instruments(h, o)
    str = ""
    j = 0
    for i in 0...h.count do
      if h[i] == "Other"
        str += (o[j] + ",")
        j += 1
      else
        str += (h[i] + ",")
      end
    end
    return str.chomp(",")
  end

  def serialize_availabilities(d, s, e)
    str = ""
    for i in 0...d.count do
      a = Availability.new(d[i], s[i], e[i])
      str += Availability.serialize(a)
    end
    return str
  end
end
