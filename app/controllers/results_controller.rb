class ResultsController < ApplicationController

  def show
    @year = Year.find_by(id: params[:id])
    if not @year
      flash[:danger] = "Year not found"
      redirect_to :root
    end
  end

  def destroy
    redirect_to :root
  end
end
