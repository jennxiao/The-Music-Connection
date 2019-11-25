class Teacher < ActiveRecord::Base
  include ContactValidation
  
  has_many :classes
  accepts_nested_attributes_for :classes, :reject_if => :all_blank, :allow_destroy => true

end
