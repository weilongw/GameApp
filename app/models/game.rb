# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  attr_accessible :name, :user_id
  validates :name, :length=>{:maximum => 20}

end
