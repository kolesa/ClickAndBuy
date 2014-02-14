module ShopsHelper

  def tag_to_json
    category = Menu.pluck(:name)
    result = []
    Hash[(0...category.size).zip category].each do |k,v|
      result.push Hash[:id => v, :text => v]
    end
    result.to_json
  end

end
