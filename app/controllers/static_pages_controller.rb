class StaticPagesController < ApplicationController
  
  def index
    @partner = Partner.new
    @item = Item.where(published: true)
  end

  def about
  end

  def item
  end

  def partner
  end

  
  # GET /categories
  def category
    @categories = ActsAsTaggableOn::Tag.where(:parent => 0).order(:parent, :order)
  end

  def category_sort
    category = params[:order]
    category.each do |k, v|
      id, parent, order = v
      p "#{id} -> #{parent} | #{order}"
      ActsAsTaggableOn::Tag.find(id).update(order: order, parent: parent)
    end
    render nothing: true
  end

  def category_sort_add
    p "[!] ADD -> #{params[:tag]}"
    i = Item.find(0)
    i.tag_list.add(params[:tag])
    i.save
    render nothing: true
  end

  def category_sort_delete
    ActsAsTaggableOn::Tag.find(params[:id]).delete
    render nothing: true
  end

  def category_sort_edit
    ActsAsTaggableOn::Tag.find(params[:id]).update(:name => params[:tag])
    render nothing: true
  end
end
