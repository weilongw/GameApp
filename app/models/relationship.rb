class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, class_name: "Geek"
  belongs_to :followed, class_name: "Geek"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
