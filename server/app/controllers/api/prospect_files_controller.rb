class Api::ProspectFilesController < ApplicationController
  def import
    @prospect_file = ProspectFile.new(prospect_file_params)
    @prospect_file.user = @user
    

    if @prospect_file.save
      ImportProspectsJob.perform_later(@prospect_file)
      render json: { message: "Prospects are being imported.", prospect_file_id: @prospect_file.id }, status: :ok
    else
      render json: {errors: @prospect_file.errors.full_messages}, status: :unprocessable_entity
    end

  end

  def progress
    @prospect_file = @user.prospect_files.find(params[:id])

    render json: { total: @prospect_file.total, done: @prospect_file.prospects.count}, status: :ok
  end


  def prospect_file_params
    params.permit(:file, :email_index, :first_name_index, :last_name_index, :force, :has_headers)
  end
end
