# IMPORTANT: This plugin requires installation of the fiveruns-manage gem.
# Stub generated 2008-04-18T14:18:19Z using fiveruns-manage-0.9.9

ALLOW_FIVERUNS_MANAGE_SCRIPTS = %w(server irb mongrel_rails) unless defined?(ALLOW_FIVERUNS_MANAGE_SCRIPTS)

if ALLOW_FIVERUNS_MANAGE_SCRIPTS.include?(File.basename($0)) || ENV['LOAD_FIVERUNS_MANAGE']

  load_plugin = begin
    if File.directory?(vendor_path = File.join(RAILS_ROOT, 'vendor', 'fiveruns-manage')) && ENV['LOAD_FIVERUNS_MANAGE'] != 'gem'
      require File.join(vendor_path, 'lib/fiveruns/manage')
      :vendor
    else
      require 'rubygems'
      require 'fiveruns/manage'
      :gem
    end
  rescue LoadError
    STDERR.puts "[FiveRuns Manage] Requires fiveruns-manage gem or vendor/fiveruns-manage"
    false
  end

  if load_plugin
    Fiveruns::Manage::Version::STUB_VERSION = Fiveruns::Manage::Version.new(*[0, 9, 9])
    if File.file?(plugin_config = File.join(RAILS_ROOT, 'config', 'fiveruns_manage.rb'))
      require plugin_config
    end
    Fiveruns::Manage::Plugin.start(load_plugin)
  end
  
end