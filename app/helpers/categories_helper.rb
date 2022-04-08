module CategoriesHelper

  def category_name c
    if I18n.locale != :en
      c.secondary_name.present? ? c.secondary_name : c.name
    else
      c.name
    end
  end

  def category_sort_order
    primary_sort = I18n.locale != :en ? :secondary_name : :name
    secondary_sort = I18n.locale != :en ? :name : :secondary_name
    "#{primary_sort} ASC, #{secondary_sort} ASC"
  end

end
