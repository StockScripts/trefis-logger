require 'rails_helper'

describe Stock do
  it "should have many stocks" do
    #t = Stock.reflect_on_association(:prices)
    #t.macro.should == :has_many
    should have_many(:prices)
  end
end

