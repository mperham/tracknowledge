require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Tracks, "index action" do
  before(:each) do
    dispatch_to(Tracks, :index)
  end
end