require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_no_name_no_comment
    feedback = Feedback.new
    refute_predicate feedback, :valid?
  end

  def test_no_name
    feedback = Feedback.new(comment: 'comment text')
    refute_predicate feedback, :valid?
  end

  def test_no_comment
    feedback = Feedback.new(name: 'name')
    refute_predicate feedback, :valid?
  end

  def test_valid_feedback
    feedback = Feedback.new(name: 'name', comment: 'comment text')
    assert_predicate feedback, :valid?
  end
end
