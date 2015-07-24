class ParticipantsController < ApplicationController

  def index; end

  def create
    importer = DataImporter.import(params[:file], params[:year])
    importer.successful? ? display_success_message : display_failure_message(importer)
    redirect_to :root
  end

  private

  def display_success_message
    flash[:success] = "File uploaded successfully"
  end

  def display_failure_message(importer)
    flash[:alert] = importer.error_message
  end

end
