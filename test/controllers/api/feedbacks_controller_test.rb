require 'test_helper'

module Api
  class FeedbacksControllerTest < ActionDispatch::IntegrationTest
    def test_create_valid
      assert_difference 'Feedback.count', 1 do
        post api_feedbacks_path, params: { feedback: { name: 'Tyler', comment: 'This is awesome'}}
      end

      assert_response :no_content
      assert_equal 'Tyler', Feedback.last.name
      assert_equal 'This is awesome', Feedback.last.comment
    end

    def test_create_invalid
      assert_no_difference 'Feedback.count' do
        post api_feedbacks_path, params: { feedback: { name: '' }}
      end

      assert_response :unprocessable_entity
      assert_equal 'Invalid feedback', JSON.parse(response.body)['error']
    end
  end
end
