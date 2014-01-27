class StaticPagesController < ApplicationController
  
  def index
    @partner = Partner.new
    @item = Item.all
  end

  def about
  end

  def item
  end

  def partner
  end
end
