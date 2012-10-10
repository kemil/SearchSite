require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  test "duplicate url" do
    p = pictures(:boat_picture1)
    
    pic = Picture.new(:url => p.url, :width => p.width, :height => p.height, 
                      :description => p.description, :imageable => p.imageable)
    
    assert !pic.save
  end
end
