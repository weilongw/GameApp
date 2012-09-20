class Play < ActiveRecord::Base
  attr_accessible :comment, :content
  validates :geek_id, presence: true
  validates :comment, :length=> {:maximum => 140}
  validates :content, :length=> {:maximum => 50, :minimum=>3}
  belongs_to :geek
  default_scope order: 'plays.created_at DESC'
end
