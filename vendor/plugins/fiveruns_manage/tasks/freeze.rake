require 'fileutils'

FIVERUNS_MANAGE_VENDOR_PATH = File.join(RAILS_ROOT, 'vendor', 'fiveruns-manage').freeze

namespace :fiveruns do
  
  namespace :manage do
   
    namespace :freeze do
      
      desc "Extract the current fiveruns-manage gem to vendor/fiveruns-manage"
      task :gem => ['fiveruns:manage:load_from_gem', 'fiveruns:manage:unfreeze:gem', :environment] do        
        rm_rf FIVERUNS_MANAGE_VENDOR_PATH rescue nil
        cp_r Fiveruns::Manage::GEM_ROOT, FIVERUNS_MANAGE_VENDOR_PATH
      end
            
    end 
    
    namespace :unfreeze do
      
      desc "Remove vendor/fiveruns-manage"
      task :gem do
        rm_rf FIVERUNS_MANAGE_VENDOR_PATH rescue nil
      end      
      
    end
    
    task :load_from_gem do
      ENV['LOAD_FIVERUNS_MANAGE'] = 'gem'
    end
    
    task :load_from_vendor do
      ENV['LOAD_FIVERUNS_MANAGE'] = 'vendor'
    end
    
  end
  
end
