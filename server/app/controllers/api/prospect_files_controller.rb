class ProspectFilesController < ApplicationController
  def import
    # Create a new ProspectFile
    prospect_file = ProspectFile.new
    prospect_file.file = params[:file]
    prospect_file.save

    # Send the file to the import job
    ImportProspectsJob.perform_later(prospect_file.id)

    # Return the status of the import job
    render json: { status: prospect_file.status }
  end

  def progress
    prospect_file = ProspectFile.find(params[:id])

    render json: { total: prospect_file.total, done: prospect_file.done }
  end
end
