module ProductsHelper

  def product_listing_for(category, &block)
    products_for(category).in_groups_of(3, '&nbsp;', &block)
  end

  CATEGORY_KEY_TO_NAME = {
    :tracks => 'General Track Stuff',
    :formula_one => 'Formula 1',
    :motogp => 'Moto GP',
    :wsbk => 'World Superbike',
    :nascar => 'NASCAR',
    :irl => 'Indy Racing League',
    :motocross => 'MotoCross',
    :drag_racing => 'Drag Racing'
  }
  CATEGORY_NAME_TO_KEY = CATEGORY_KEY_TO_NAME.invert

  private
  
  def products_for(category)
    (PRODUCT_IDS[category.to_sym] || []).map { |id| PRODUCT_HTML.gsub(/PRODID/, id) }
  end
  
  PRODUCT_HTML = "<iframe src='http://rcm.amazon.com/e/cm?t=tracknowledge-20&o=1&p=8&l=as1&asins=PRODID&fc1=000000&IS2=1&lt1=_blank&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr' style='width:120px;height:240px;' scrolling='no' marginwidth='0' marginheight='0' frameborder='0'></iframe>"

  PRODUCT_IDS = {
    :formula_one => %w(1844253406 1844254534 0752827839 8879113984 2847071393),
    :drag_racing => %w(0760326975 193249443X 1932494448 B000PWNK00)
  }
  
end
