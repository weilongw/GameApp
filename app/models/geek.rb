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
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  def feed
     Play.from_users_followed_by(self)
  end

  def following?(other_geek)
    relationships.find_by_followed_id(other_geek.id)
  end

  def follow!(other_geek)
    relationships.create!(followed_id: other_geek.id)
  end

  def unfollow!(other_geek)
    relationships.find_by_followed_id(other_geek.id).destroy
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
