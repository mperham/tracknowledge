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
  
  def google_maps_header
    controller.controller_name == 'tracks' ?
      GMap.header : ''
	end
	
	def row_style(index)
	  "class='#{index % 2 == 0 ? 'even' : 'odd'}'"
  end
end
