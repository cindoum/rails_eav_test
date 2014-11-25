require 'test_helper'

class CoreExtTest < ActiveSupport::TestCase
  def test_to_strung_prepend_word
    assert_equal "SUPER hello world", "hello world".to_strung
  end
end
