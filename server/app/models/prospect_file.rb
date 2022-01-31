class ProspectFile < ApplicationRecord
  has_one_attached :file

  validates :file, :email_index, presence: true
  validates :email_index, numericality: { only_integer: true }, inclusion: { in: 0..100, message: "must be a number between 0 and 100" }
  validates :first_name_index, :last_name_index, allow_nil: true, allow_blank: true, numericality: { only_integer: true }, inclusion: { in: 0..100, message: "must be a number between 0 and 100" }
  validate :file_must_be_csv

  def import_prospects 
    
  end

  def file_must_be_csv
    if !file.content_type.in?(%w(text/csv text/plain))
      errors.add(:file, "must be a CSV file")
    end
  end
end
