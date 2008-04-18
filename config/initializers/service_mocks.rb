if RAILS_ENV == 'development'
  require 'ostruct'
  module Youtube
    class Video
      def self.find(*args)
        search = OpenStruct.new(:entry => [])
        5.times do |idx|
          search.entry << OpenStruct.new(
            :group => OpenStruct.new(
              :player => OpenStruct.new(:url => "http://youtube.com/video#{idx}"),
              :thumbnail => [OpenStruct.new(:url => "http://youtube.com/thumb#{idx}.jpg", :width => '130', :height => '97')]
              ), 
            :title => "Video #{idx}")
        end
        search
      end
    end
  end
end