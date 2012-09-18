class Game < ActiveRecord::Base
  attr_accessible :name, :user_id
  validates :name, :length=>{:maximum => 20}

end
