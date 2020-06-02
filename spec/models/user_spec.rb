require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    it "valid all fields" do
      user = User.new(name: "test", email: "test@test.com", password: "passpass", password_confirmation: "passpass")
      user.save()
      expect(user.errors.full_messages).to match_array([])
    end

    it "invalid same email" do
      first_user = User.new(name: "test", email: "test@test.com", password: "passpass", password_confirmation: "passpass")
      first_user.save()
      second_user = User.new(name: "test", email: "test@test.com", password: "passpass", password_confirmation: "passpass")
      second_user.save()
      expect(second_user.errors.full_messages).to_not be_empty
    end

    it "invalid same email case incesitive" do
      first_user = User.new(name: "test", email: "test@test.com", password: "passpass", password_confirmation: "passpass")
      first_user.save()
      second_user = User.new(name: "test", email: "test@TEST.com", password: "passpass", password_confirmation: "passpass")
      second_user.save()
      expect(second_user.errors.full_messages).to_not be_empty
    end

    it "invalid missing email" do
      user = User.new(name: "test", password: "passpass", password_confirmation: "passpass")
      user.save()
      expect(user.errors.full_messages).to_not be_empty
    end

    it "invalid missing name" do
      user = User.new(email: "test@test.com", password: "passpass", password_confirmation: "passpass")
      user.save()
      expect(user.errors.full_messages).to_not be_empty
    end

    describe "Password" do
      it "long enugh" do
        user = User.new(name: "test", email: "test@test.com", password: "passpass", password_confirmation: "passpass")
        user.save()
        expect(user.errors.full_messages).to be_empty
      end
  
      it "not long enough" do
        user = User.new(name: "test", email: "test@test.com", password: "t", password_confirmation: "t")
        user.save()
        expect(user.errors.full_messages).to_not be_empty
      end
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(name: "test", email: "test@test.com", password: "passpass", password_confirmation: "passpass")
      @user.save()
    end
    
    it "basic success" do
      result = User.authenticate_with_credentials("test@test.com", "passpass")
      expect(result).to eq(@user)
    end

    it "remove surrounding spaces" do
      result = User.authenticate_with_credentials(" test@test.com ", "passpass")
      expect(result).to eq(@user)
    end

    it "email case insensitive" do
      result = User.authenticate_with_credentials("TEST@test.com", "passpass")
      expect(result).to eq(@user)
    end
  end
end
