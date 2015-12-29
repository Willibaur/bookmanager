feature 'Recovering Password' do
  before do
    sign_up
    Capybara.reset!
    allow(SendRecoverLink).to receive(:call)
  end

  let(:user) { User.first }

  def recover_password
    visit '/users/recover'
    fill_in :email, with: 'user_name@email.com'
    click_button 'Submit'
  end

  scenario 'When I forget my password I can see a link to reset' do
    visit '/sessions/new'
    click_link 'I forgot my password'
    expect(page).to have_content('Please enter your email address')
  end

  scenario 'When I enter my email I am told to check my inbox' do
    recover_password
    expect(page).to have_content 'Thanks, Please check your inbox for the link.'
  end

  scenario 'Assigned a reset token to the user when they recover' do
    sign_up
    expect { recover_password }.to change { User.first.password_token }
  end

  scenario 'It does not allow user to use the token after an hour' do
    recover_password
    Timecop.travel(60 * 60 * 60) do
      visit("/users/reset_password?token=#{user.password_token}")
      expect(page).to have_content 'Your token is invalid'
    end
  end

  scenario 'It asks user for new password when token is valid' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content('Please enter your new password')
  end

  scenario 'it lets you enter a new password with a valid token' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: 'newpassword'
    fill_in :password_confirmation, with: 'newpassword'
    click_button 'Submit'
    expect(page).to have_content('Please Sign in')
  end

  scenario 'it lets you sign in after password reset' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: 'newpassword'
    fill_in :password_confirmation, with: 'newpassword'
    click_button 'Submit'
    sign_in(email: 'user_name@email.com', password: 'newpassword')
    expect(page).to have_content 'Welcome, user_name@email.com'
  end

  scenario "it lets you know if your passwords don't match" do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: 'newpassword'
    fill_in :password_confirmation, with: 'wrong_password'
    click_button 'Submit'
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'it calls the SendRecoverLink service to send the link' do
    expect(SendRecoverLink).to receive(:call).with(user)
    recover_password
  end
end
