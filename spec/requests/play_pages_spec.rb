require 'spec_helper'

describe "Play pages" do

  subject { page }

  let(:geek) { FactoryGirl.create(:geek) }
  before { sign_in geek }

  describe "play creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a new play" do
        expect { click_button "Post" }.not_to change(Play, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'play_content', with: "Lorem ipsum" }
      it "should create a play" do
        expect { click_button "Post" }.to change(Play, :count).by(1)
      end
    end
  end
end
