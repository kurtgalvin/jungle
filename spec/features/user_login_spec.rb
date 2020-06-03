require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @email = "test@test.com"
    @password = 'passpass'
    user = User.new(name: "TEST", email: @email, password: @password, password_confirmation: @password)
    user.save
  end

  scenario "They sign in" do
    visit '/login'
    
    fill_in 'email', with: @email
    fill_in 'password', with: @password

    click_on 'Submit'

    expect(page).to have_content "Log Out"
  end
end
