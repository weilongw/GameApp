# == Schema Information
#
# Table name: examples
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Example < ActiveRecord::Base
  attr_accessible :name
end
