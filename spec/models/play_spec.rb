require 'spec_helper'

describe Play do

  let(:geek) { FactoryGirl.create(:geek) }
  before {@play = geek.plays.build(content:"Dota", comment:"very cool")}

  subject { @play }

  it { should respond_to(:content) }
  it { should respond_to(:comment) }
  it { should respond_to(:geek_id) }
  its(:geek) {should == geek}
  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Play.new(geek_id:  geek.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end