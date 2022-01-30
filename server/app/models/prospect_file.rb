class ProspectFile < ApplicationRecord
  has_one_attached :file

  validates :file, presence: true

  enum status: {
    pending: 0,
    processing: 1,
    done: 2,
    error: 3
  }

  def import_prospects 
    
  end
end
