ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'rubygems'
require 'flexmock/test_unit'
require 'ostruct'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  fixtures :all

  def assert_not(val)
    assert !val
  end
end
