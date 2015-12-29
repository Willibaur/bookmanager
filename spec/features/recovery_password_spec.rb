feature 'Recovering Password' do
  before do
    sign_up
    Capybara.reset!
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
end
