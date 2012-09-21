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

require 'spec_helper'

describe Geek do

  before do
    @user = Geek.new(name: "Example User", email: "user@example.com", password: "foobar",
                      password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:plays) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }
  it { should be_valid }

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_geek) { Geek.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_geek.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:geek_for_invalid_password) { found_geek.authenticate("invalid") }

      it { should_not == geek_for_invalid_password }
      specify { geek_for_invalid_password.should be_false }
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end



  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "play associations" do

    before { @user.save }
    let!(:older_play) do
      FactoryGirl.create(:play, geek: @user, created_at: 1.day.ago)
    end
    let!(:newer_play) do
      FactoryGirl.create(:play, geek: @user, created_at: 1.hour.ago)
    end

    it "should have the right plays in the right order" do
      @user.plays.should == [newer_play, older_play]
    end
    it "should destroy associated plays" do
      plays = @user.plays
      @user.destroy
      plays.each do |play|
        play.find_by_id(play.id).should be_nil
      end
    end

  end
  describe "following" do
    let(:other_user) { FactoryGirl.create(:geek) }
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "and unfollowing" do
      before { @user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end
  end
end
