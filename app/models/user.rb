class User < ActiveRecord::Base
  attr_accessible :email, :game_id, :name
end
