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

class Geek < ActiveRecord::Base
  attr_accessible :email, :game_id, :name, :password, :password_confirmation
  has_secure_password
  VALID_EMAIL_REGEX =   /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence=> true, :length => {:maximum => 30}
  validates :email, :presence=> true, :format=> { :with=> VALID_EMAIL_REGEX } ,
              :uniqueness => true
  before_save {|geek| geek.email = email.downcase }
  before_save :create_remember_token
  validates :password, :presence => true, :length => {:minimum => 6}
  validates :password_confirmation, :presence => true
  has_many :plays, dependent: :destroy

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
