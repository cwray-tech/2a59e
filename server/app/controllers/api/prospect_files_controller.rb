class Api::ProspectFilesController < ApplicationController
  def import
    prospect_file = ProspectFile.new(prospect_file_params)
    prospect_file.user = @user
    prospect_file.save

    if !prospect_file.valid?  
      render json: {errors: prospect_file.errors.full_messages}, status: :unprocessable_entity
    else
      # ImportProspectsJob.perform_later(prospect_file)
      prospect_file.import_prospects
      render json: { message: "Prospects are being imported." }, status: :ok
    end

  end

  def progress
    prospect_file = ProspectFile.find(params[:id])

    render json: { total: prospect_file.total, done: prospect_file.done }
  end


  def prospect_file_params
    params.permit(:file, :email_index, :first_name_index, :last_name_index, :force, :has_headers)
  end
end
