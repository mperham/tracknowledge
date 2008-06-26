module Fiveruns::Manage::Targets::Rails::CGI
  
  module Session
  
    def self.included(base)
      Fiveruns::Manage.instrument base, InstanceMethods
    end
  
    module InstanceMethods
      def initialize_with_fiveruns_manage(*args, &block)
        Fiveruns::Manage.tally :sess_creates do
          initialize_without_fiveruns_manage(*args, &block)
        end
      end
      def close_with_fiveruns_manage(*args, &block)
        Fiveruns::Manage.tally :sess_closes do
          close_without_fiveruns_manage(*args, &block)
        end
      end
      def delete_with_fiveruns_manage(*args, &block)
        Fiveruns::Manage.tally :sess_dels do
          delete_without_fiveruns_manage(*args, &block)
        end
      end
    end
    
  end

end