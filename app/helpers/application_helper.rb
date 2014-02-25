module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  
  def full_title(page_title)
    base_title = "LikeAndBuy"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  #def generate_menu
  #  ActsAsTaggableOn::Tag.where(:parent => 0).order(:parent, :order)
  #end
end
