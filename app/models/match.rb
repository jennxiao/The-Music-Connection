class Match < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :teacher
  belongs_to :parent

  validates :score,   presence: true, 
                      numericality: { only_integer: true }, 
                      maximum: AdminHelper.MAX_WEIGHT, 
                      minimum: 0
  validates :forced,  inclusion: { in: [true, false] }

  validate :one_tutor_one_client
  
  def one_tutor_one_client
    if !tutor.present?
      errors.add("Tutor missing in match")
    end
    if !teacher.present? && !parent.present?
      errors.add("Client missing in match")
    end
    if teacher.present? && parent.present?
      errors.add("Both teacher and parent present in match (must be one to one):", :teacher, :parent)
    end
  end
  
end
