module MenusHelper
  #def nested_menus(menus)
  #  menus.map do |menu, sub_menus|
  #    content_tag(:div, render(menu) + content_tag(:div, nested_menus(sub_menus), :class => "nested_menus"), :class => "nested_menus_root")
  #  end.join.html_safe
  #end
  def generate(menus)
    menus.map do |menu, sub_menu|
        content_tag :li, :id => dom_id(menu), :class => 'well well-sm' do
          render('menus/menu', {menu: menu}) + (content_tag(:ul, generate(sub_menu)) if sub_menu.present?)
        end
    end.join.html_safe
  end
end
