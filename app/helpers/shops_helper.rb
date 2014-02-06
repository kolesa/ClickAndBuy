module ShopsHelper

  def tags_to_json
    category = Item.find(0).tag_list
    result = []
    Hash[(0...category.size).zip category].each do |k,v|
      result.push Array([v, k])
    end
    result.to_a
  end
end
