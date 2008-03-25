# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def notice
    flash[:notice]
  end
  
  def area
    @controller.class.name.gsub /Controller/, ''
  end
  
  def image_button(path, html_options={})
    alt = html_options.delete(:alt) || ''
    content_tag(:button, image_tag(path, :alt => alt), html_options)
  end
end
