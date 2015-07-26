class ResultsController < ApplicationController

  def show
    @year = Year.find_by(id: params[:id])
    if not @year
      flash[:danger] = "Year not found"
      redirect_to :root
    end
  end

  def destroy
    year = Year.find_by(id: params[:id])
    year.destroy
    flash[:success] = 'Results deleted'
    redirect_to :root
  end
end
