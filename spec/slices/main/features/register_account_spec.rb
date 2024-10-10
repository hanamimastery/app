# frozen_string_literal: true

RSpec.feature "Account registrations", :main_db do
  scenario "Renders the form" do
    visit '/signup'
    expect(page).to have_content('Nickname')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_content('I agree to the terms and conditions & privacy policy')
    expect(page).to have_content('Register account')
  end

  scenario "Renders successful notice" do
    visit '/signup'

    fill_in 'Nickname', with: 'jsmith'
    fill_in 'Password', with: 'secret'
    fill_in 'Password confirmation', with: 'secret'
    check 'registration-tac'
    click_button 'Register account'

    expect(page).to have_content('Account successfully registered!')
  end

  scenario "Renders error notice" do
    visit '/signup'

    fill_in 'Nickname', with: 'jsmith'
    fill_in 'Password confirmation', with: 'secret'
    check 'registration-tac'
    click_button 'Register account'
    expect(page).to have_content('There were errors with your form validation')
    expect(page).to have_content('must be filled')
  end
end
