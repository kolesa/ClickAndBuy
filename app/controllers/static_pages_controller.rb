class StaticPagesController < ApplicationController

  def index
    @item = Item.where(published: true)
    @banner = true;
  end

  def about
  end

  def item
  end

  def partner
  end

  # GET /search
  def search
    p "[!]recv: #{params[:search]}"
    result = Item.where("lower(name) LIKE lower(?)", "%#{params[:search].downcase}%")
    
    result.each do |s|
      s.avatar_file_name    = s.avatar.url(:thumb)
      s.avatar_content_type = item_url(s)
    end

    user = User.search(params[:search])
    user.each do |s|
      s.avatar_file_name    = s.avatar.url(:thumb)
      s.avatar_content_type = user_info_url(s)
      result.push(s)
    end

    

    render json: result.to_json
  end
  
end
