class Api::ProspectFilesController < ApplicationController
  def import
    # Create a new ProspectFile
    prospect_file = ProspectFile.new
    prospect_file.file = params[:file]
    prospect_file.email_index = params[:email_index]
    prospect_file.first_name_index = params[:first_name_index]
    prospect_file.last_name_index = params[:last_name_index]
    prospect_file.force = params[:force]
    prospect_file.has_headers = params[:has_headers]
    prospect_file.save

    # If the validation fails, return an error
    if !prospect_file.valid?  
      render json: {errors: prospect_file.errors.full_messages}, status: :unprocessable_entity
    else
      ImportProspectsJob.perform_later(prospect_file)
      
      # Return success message
      render json: { message: "Prospects are being imported." }, status: :ok
    end

  end

  def progress
    prospect_file = ProspectFile.find(params[:id])

    render json: { total: prospect_file.total, done: prospect_file.done }
  end
end
