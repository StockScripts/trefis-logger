require 'pry'

n=20
n.times do 
  stock = Stock.first
  last_price = stock.prices.order(:date).reverse.first
  future_price = last_price.market_price + rand(10)/10.0
  future_date  = last_price.date + 1.day      
  stock.prices <<  Price.find_or_create_by(trefis_analyst_price: last_price.trefis_analyst_price, market_price: future_price,date: future_date)
  #binding.pry
end
