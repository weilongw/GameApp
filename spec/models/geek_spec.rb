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
end
