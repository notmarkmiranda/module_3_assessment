class ResultsController < ApplicationController

  def index
    results = Result.find_stores(params[:search][:zip])
    @count = results.count
    @results = results.paginate(page: params[:page], per_page: 15)
  end

  def show
    @store = Result.single_store(params[:store_id])
    @hours = @store.hours.split(";")
  end
end
