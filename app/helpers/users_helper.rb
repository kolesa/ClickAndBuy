module UsersHelper
  def shop
    Shop.find(like.item.shop_id)
  end
end
