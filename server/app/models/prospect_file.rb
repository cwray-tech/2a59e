class ProspectFile < ApplicationRecord
  has_one_attached :file

  validates :file, presence: true

  def import_prospects 
    
  end
end
