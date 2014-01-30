module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def generate_menu
    ActsAsTaggableOn::Tag.where(:parent => 0).order(:parent, :order)
  end

end
