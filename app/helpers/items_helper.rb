module ItemsHelper
  include ActsAsTaggableOn::TagsHelper

  def tags_to_json
    category = Item.find(0).tag_list
    result = []
    Hash[(0...category.size).zip category].each do |k,v|
      result.push Hash[:id =>v, :text => v]
    end
    result.to_json
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end  

end
