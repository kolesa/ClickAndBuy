module StaticPagesHelper
  def generate_menu(menus)
    menus.map do |menu, sub_menu|
        menu.root? ? root="dropdown" : root = nil
        content_tag :li, :class => root do
          render('static_pages/menu', {menu: menu, root: root}) + (content_tag(:ul, generate_menu(sub_menu), :class => 'dropdown-menu') if sub_menu.present?)
        end
    end.join.html_safe
  end
end
