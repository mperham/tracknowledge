module ProductsHelper

  def product_listing_for(category, &block)
    products_for(category).in_groups_of(3, '&nbsp;', &block)
  end

  CATEGORY_KEY_TO_NAME = {
    :tracks => 'General Track Stuff',
    :formula_one => 'Formula 1',
    :motogp => 'MotoGP',
    :wsbk => 'World Superbike',
    :nascar => 'NASCAR',
    :irl => 'Indy Racing League',
    :motocross => 'Motocross',
    :drag_racing => 'Drag Racing'
  }
  CATEGORY_NAME_TO_KEY = CATEGORY_KEY_TO_NAME.invert

  private
  
  def products_for(category)
    (PRODUCT_IDS[category.to_sym] || []).map { |id| PRODUCT_HTML.gsub(/PRODID/, id) }
  end
  
  PRODUCT_HTML = "<iframe src='http://rcm.amazon.com/e/cm?t=tracknowledge-20&o=1&p=8&l=as1&asins=PRODID&fc1=000000&IS2=1&lt1=_blank&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr' style='width:120px;height:240px;' scrolling='no' marginwidth='0' marginheight='0' frameborder='0'></iframe>"

  PRODUCT_IDS = {
    :formula_one => %w(1844253406 1844254534 0752827839 8879113984 2847071393 B000CBXGP8),
    :drag_racing => %w(0760326975 193249443X 1932494448 B000PWNK00 1932494375 1932494642),
    :motogp => %w(B000WQWQ2C B000OCXK5G B000JU7JF0 1893618919 B000V1OUSQ B000OCXK5G),
    :tracks => %w(0753460408 1859608124 0760334315 1403942897 0760328668 184425139X),
    :nascar => %w(B000OQ3TQW 0525950532 1572438479 B000Y8SE1U 0743226259 B000LP671K),
    :wsbk => %w(1844254747 B001505NX8 B000YKI4OA 1905334222 0785818782 1578650917),
    :irl => %w(1583881514 1583880526 B00084LK3Y 1582617279 B00127QEBE 0743298306),
    :motocross => %w(B000S88JTS B0009XT8C4 B000A2UBKW 0760318026 B000AQ69T0 B000BBOUO0)
  }
  
end
