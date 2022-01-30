class ImportProspectsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Find the prospect file
    prospect_file = ProspectFile.find(args[0])

    # Import the prospects
    prospect_file.import_prospects

    # Update the status of the prospect file
    prospect_file.update_status

    # Send the status of the import job
    ActionCable.server.broadcast "prospect_files_channel",
      status: prospect_file.status

    # Return the status of the import job
    render json: { status: prospect_file.status }
  end
end
