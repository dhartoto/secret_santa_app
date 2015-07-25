class ResultsController < ApplicationController

  def show
    @year = Year.find_by(year: 2015)
  end
end
