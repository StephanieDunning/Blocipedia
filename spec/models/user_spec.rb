require 'rails_helper'
include RandomData

RSpec.describe User, type: :model do

  let(:user) { User.create!(name: "Blocipedia User", email: "user@blocipedia.com", password: "password") }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@blocipedia.com").for(:email) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Blocipedia User", email: "user@blocipedia.com")
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) { User.new(name: "", email: "user@blocipedia.com") }
    let(:user_with_invalid_email) { User.new(name: "Blocipedia User", email: "") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "after_create" do
    before do
      @another_user = User.new(name: "Blochead", email: 'blochead@io.com', password: 'helloworld', password_digest: 'helloworld')
    end

    it "sends an email to new users" do
      expect(UserMailer).to receive(:new_user).with(@another_user).and_return(double(deliver_now: true))
      @another_user.save
    end
  end
end
