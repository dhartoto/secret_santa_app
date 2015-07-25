class ResultsController < ApplicationController

  def show
    @year = Year.find_by(id: params[:id])
  end
end
