class Feedback < ApplicationRecord
  validates_presence_of :name, :comment
end
