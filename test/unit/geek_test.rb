# == Schema Information
#
# Table name: geeks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GeekTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
