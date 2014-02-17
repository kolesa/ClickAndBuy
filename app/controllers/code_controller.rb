class CodeController < ApplicationController
  before_action :set_item, only: [:generate, :download]

  def generate
    # 1) Уменьшаем кол-во товара
    # 2) Like -> ended: true 
    # 3) Code -> code : generate
    #
    p "like: #{@like.item.id}, count:#{@like.counters.count}"
    
    # ищем максимальную доступную скидку
    discount = Discount.where(
      "item_id = ? and
       likes <= ? and
       count > 0", @like.item.id, @like.counters.count)\
      .order("discount DESC").first

    # 1) Создаём код 
    Code.create!(
      user_id: @like.user.id,
      item_id: @like.item.id,
      code: Digest::MD5.hexdigest(rand.to_s),
      discount: discount)
    
    # 2) Обновляем лайк
    @like.update!(ended: true)

    # 3) Уменьшаем  кол-во товара по скидке
    discount.decrement!(:count)

    redirect_to user_info_path(@like.user)
  end

  def download
    render :template => 'code/download.pdf.slim',
      :pdf => "show",
      :layout => 'application'
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_item
      @like = Like.find(params[:id])
    end
end
