require 'spec_helper'

describe "User pages" do

  subject { page }
  describe "index" do
    before do
      sign_in FactoryGirl.create(:geek)
      FactoryGirl.create(:geek, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:geek, name: "Ben", email: "ben@example.com")
      visit geeks_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:geek) } }
      after(:all)  { Geek.delete_all }



      it "should list each user" do
        Geek.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end

  describe "profile page" do
    # Code to make a user variable
    let(:geek) {FactoryGirl.create(:geek)}
    let!(:m1) { FactoryGirl.create(:play, geek: geek, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:play, geek: geek, content: "Bar") }
    before { visit geek_path(geek) }

    it { should have_selector('h1',    text: geek.name) }
    it { should have_selector('title', text: geek.name) }
    describe "plays" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(geek.plays.count) }
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(Geek, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(Geek, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:geek) { FactoryGirl.create(:geek) }
    before do
      sign_in geek
      visit edit_geek_path(geek)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: geek.password
        fill_in "Confirm Password", with: geek.password
        click_button "Save changes"
      end
      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { geek.reload.name.should  == new_name }
      specify { geek.reload.email.should == new_email }

    end
  end
end