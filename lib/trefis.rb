require 'rubygems'
require 'nokogiri'
require 'csv'
require 'open-uri'
require 'pry'

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
  security[:date] = Time.now
  securities << security 
  binding.pry
end


