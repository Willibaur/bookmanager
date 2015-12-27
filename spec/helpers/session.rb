# Session Helpers
module SessionHelpers
  def sign_in(email:, password:)
    visit '/sessions/new'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
  end

  def sign_up(email: 'user_name@email.com',
              password: 'secret1234',
              password_confirmation: 'secret1234')

    visit '/users/new'
    expect(page.status_code).to eq(200)

    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end
end
