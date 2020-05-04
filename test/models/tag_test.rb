require 'test_helper'

class TagTest < ActiveSupport::TestCase

  def setup        
    @tag_one = tags(:one)
    @tag_one.save
    @existingTag = @tag_one.name
  end

  test "verifyThatGetIdReturnsnilIfTagDoesntExists" do
    tag_name = "aklfnaslfrnaslejfnojernfamfadsfnasdljfnoweinslm"
    tag_id = Tag.GetId(tag_name)    
    assert (tag_id == nil)    
  end

  test "verifyThatGetIdReturnsIdIfTagExists" do    
    tag_id = Tag.GetId(@existingTag)    
    assert (tag_id == @tag_one.id)    
  end

end
