require 'test_helper'
 
class ActsAsPropifyTest < ActiveSupport::TestCase
    def test_propify_all 
       props = User.propify_all 
       assert_equal 1, props.count
    end
    
    def test_propify_all 
      count = User.propify_all.count
      User.propify_create "color"
       assert_equal count + 1, User.propify_all.count
    end
end
