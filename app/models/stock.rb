class Stock < ActiveRecord::Base
  has_many :prices
end
