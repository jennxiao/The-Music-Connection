require 'rails_helper'
describe Availability do
  it 'serializes' do
    a = Availability.new('Monday', '13:00:00', '15:00:00')
    s = Availability.serialize(a)
    
    expect(s).to eq 'Monday&13:00:00&15:00:00;'
  end
  it 'deserializes' do
    a = Availability.new('Monday', '13:00:00', '15:00:00')
    s = Availability.serialize(a)
    b = Availability.deserialize(s)[0]
    t = Availability.serialize(b)
    
    expect(s).to eq 'Monday&13:00:00&15:00:00;'
    expect(t).to eq s
  end
  it 'deserializes several availabilities chained together' do
    a = Availability.new('Monday', '13:00:00', '15:00:00')
    b = Availability.new('Tuesday', '15:00:00', '16:00:00')
    c = Availability.new('Friday', '14:00:00', '15:00:00')
    sa = Availability.serialize(a)
    sb = Availability.serialize(b)
    sc = Availability.serialize(c)
    all = Availability.deserialize(sa + sb + sc)
    expect(Availability.serialize(all[0])).to eq sa
    expect(Availability.serialize(all[1])).to eq sb
    expect(Availability.serialize(all[2])).to eq sc
  end
  it 'calculates no overlap' do
    a = Availability.new('Monday', '13:00:00', '15:00:00')
    b = Availability.new('Tuesday', '15:00:00', '16:00:00')
    overlap = Availability.overlap(a, b)
    expect(overlap).to eq 0
    overlap = Availability.overlap(b, a)
    expect(overlap).to eq 0
  end
  it 'calculates encompassing overlap' do
    a = Availability.new('Monday', '13:00:00', '15:00:00')
    b = Availability.new('Monday', '13:00:00', '14:00:00')
    overlap = Availability.overlap(a, b)
    expect(overlap).to eq 3600
    overlap = Availability.overlap(b, a)
    expect(overlap).to eq 3600
  end
  it 'calculates regular overlap' do
    a = Availability.new('Monday', '13:00:00', '14:00:00')
    b = Availability.new('Monday', '13:30:00', '15:00:00')
    overlap = Availability.overlap(a, b)
    expect(overlap).to eq 1800
    overlap = Availability.overlap(b, a)
    expect(overlap).to eq 1800
  end
end
