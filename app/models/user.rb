class User < ActiveRecord::Base
  attr_accessible :email, :game_id, :name
  validates :name, :length => {:maximum => 20}
  has_many :games
end
