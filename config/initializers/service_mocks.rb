module Flickr
  class Base
    def sign_request(foo)
      # override this as it doesn't seem to work in flickr-fu 0.1.4.
      # The only request we make is flickr.photos.search which does not require authentication so it's not important
    end
  end
end


# if RAILS_ENV != 'production'
#   class Photo
#     def url(something)
#       "http://perham.net/mike/flickr.pic"
#     end
#     def title
#       "Picture"
#     end
#   end
# 
#   module Flickr
#     class Photos
#       def search(*args)
#         photos = []
#         5.times do |idx|
#           photos << ::Photo.new
#         end
#         photos
#       end
#     end
#   end
# end
