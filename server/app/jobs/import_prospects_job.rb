class ImportProspectsJob < ApplicationJob
  queue_as :default

  def perform(prospect_file)
    prospect_file.import_prospects
  end
end
