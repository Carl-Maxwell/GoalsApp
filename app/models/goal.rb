class Goal < ActiveRecord::Base

  validates :name, :user, presence: true
  validates :completed, :public_goal, inclusion: [true, false]

  after_initialize :default_completed

  belongs_to :user

  include Commentable

  def default_completed
    self.completed ||= false
  end
end
