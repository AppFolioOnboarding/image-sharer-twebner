module Api
  class FeedbacksController < ApplicationController
    def create
      feedback = Feedback.new(feedback_params)

      if feedback.save
        head :no_content
      else
        render status: :unprocessable_entity, json: { error: 'Invalid feedback'}
      end
    end

    private

    def feedback_params
      params.require(:feedback).permit(:name, :comment)
    end
  end
end
