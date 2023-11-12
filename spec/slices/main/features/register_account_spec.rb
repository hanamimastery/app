# frozen_string_literal: true

RSpec.feature "Account registrations" do
  scenario "Renders the form" do
    visit '/signup'
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_content('I agree to the terms and conditions & privacy policy')
    expect(page).to have_content('Register account')
  end

  scenario "Renders successful notice" do
    visit '/signup'

    fill_in 'Username', with: 'jsmith'
    fill_in 'Password', with: 'secret'
    fill_in 'Password confirmation', with: 'secret'
    check 'registration-tac'
    click_button 'Register account'

    expect(page).to have_content('Account successfully registered!')
  end

  scenario "Renders error notice" do
    visit '/signup'

    fill_in 'Username', with: 'jsmith'
    fill_in 'Password confirmation', with: 'secret'
    check 'registration-tac'
    click_button 'Register account'
    expect(page).to have_content('Error occured while creating the account')
  end

end
