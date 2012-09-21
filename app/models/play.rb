class Play < ActiveRecord::Base
  attr_accessible :comment, :content
  validates :geek_id, presence: true
  validates :comment, :length=> {:maximum => 140}
  validates :content, :length=> { :minimum=>3}
  belongs_to :geek
  default_scope order: 'plays.created_at DESC'
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :geek_id"
    where("geek_id IN (#{followed_user_ids}) OR geek_id = :geek_id",
          geek_id: user.id)
  end
end
