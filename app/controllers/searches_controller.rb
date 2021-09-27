class SearchesController < ApplicationController

  def index
    @params = {
      :date_travel => DateTime.now,
      :distance => 0,
      :duration => 0
    }

  end

  def search
    params = taximeter_search_params
    params[:date_travel] = params[:date_travel].present? ? params[:date_travel].to_datetime : DateTime.now
    params[:distance] = params[:distance].to_f
    params[:duration] = params[:duration].to_f

    taximeters = Taximeter.search(params[:date_travel])
    result = []
    taximeters.each do |tx|
      total = tx.minimum_price
      calculated = tx.start_price + (params[:distance] * tx.km_price) + (params[:duration] * tx.minute_price)
      total = calculated if calculated > total
      tx.total_calculated = total
      result.push(tx)
    end
    @search_result = result.sort_by(&:total_calculated)
    @params = {
      :date_travel => params[:date_travel],
      :distance => params[:distance],
      :duration => params[:duration]
    }
    respond_to do |format|
      #format.html { redirect_to search_path }
      format.html { render 'index' }
    end
  end

  private
    def taximeter_search_params
      params.require(:search).permit(:date_travel, :distance, :duration, :seats)
    end
end
