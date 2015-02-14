class StocksController < ApplicationController
  def index
    @stocks = Stock.all
  end

  def show
    @stock       = Stock.find(params[:id])
    @data        = @stock.prices.map{|price| [price.date.to_time.to_i * 1000, price.market_price] }.to_json
    @trefis_data = @stock.prices.map{|price| [price.date.to_time.to_i * 1000, price.trefis_analyst_price]}.to_json
  end
end
