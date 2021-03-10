require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'Should get home' do
    get root_url
    assert_response :success
    assert_select 'body', 'Hello World!'
  end
end
