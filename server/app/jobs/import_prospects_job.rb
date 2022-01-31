class ImportProspectsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Find the prospect file
    prospect_file = ProspectFile.find(args[0])

    prospect_file.import_prospects
  end
end
