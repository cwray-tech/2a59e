require 'csv'

class ProspectFile < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  has_many :prospects

  validates :file, :email_index, presence: true
  validate :file_must_be_csv
  validates :email_index, numericality: { only_integer: true }, inclusion: { in: 0..100, message: "must be a number between 0 and 100" }
  validates :first_name_index, :last_name_index, allow_nil: true, allow_blank: true, numericality: { only_integer: true }, inclusion: { in: 0..100, message: "must be a number between 0 and 100" }
  validates :force, :has_headers, inclusion: { in: [true, false] } , allow_blank: true, allow_nil: true

  def import_prospects 
    csv = CSV.parse(file.download, headers: has_headers)
    total = csv.count
    self.update(total: total, done: done)

    csv.each do |row|
      # Create a new prospect if it doesn't exist
      @prospect = user.prospects.find_by(email: row[email_index])
      
      if @prospect.nil?
        @prospect = user.prospects.create(
          email: row[email_index], 
          first_name: row[first_name_index], 
          last_name: row[last_name_index], 
          prospect_file: self)
      elsif force
        @prospect.update(
          first_name: row[first_name_index], 
          last_name: row[last_name_index], 
          prospect_file: self)
      end
    end
  end

  def file_must_be_csv
    if !file.content_type.in?(%w(text/csv text/plain))
      errors.add(:file, "must be a CSV file")
    end
  end
end
