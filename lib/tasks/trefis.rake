require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'



namespace :trefis do
  desc "import data from tresfis all company page and put them in the db for further processing"
  task :import => [:environment] do
  doc = Nokogiri::HTML(open("http://www.trefis.com/companies"))


  attributes = [:company,:trefis_analyst_price,:market_price,:sector,:industry]
  securities = []
 
  table = doc.xpath('//table/tbody/tr')
  table.each do |row|
    security = {} 
    tarray = [] 
    row.xpath('td').take(4).each_with_index do |cell,index|
      cell = clean(cell)
      security[attributes[index]] = cell
      if attributes[index] == :trefis_analyst_price
        security[:price_difference_percentage] = cell.split("%")[0]
        security[:trefis_analyst_price]        = cell.split("%")[1]
      end 
    end
    securities << security 
    stock = Stock.find_or_create_by(company: security[:company] ,sector: security[:sector], industry: security[:industry])
    stock.prices <<  Price.find_or_create_by(trefis_analyst_price: security[:trefis_analyst_price] , market_price: security[:market_price],date: Date.today)
     
  end


  end
end


def clean(cell)
  if !cell.nil?
    cell = cell.text
    cell = cell.gsub /\t/, ''
    cell = cell.gsub /\n/, ''
    cell = cell.gsub /\r/, ''
    cell = cell.gsub /\$/, ''
    #remove anythign after upadte
    cell = cell.gsub /update.+/i,''
  end 
  cell.strip
end


