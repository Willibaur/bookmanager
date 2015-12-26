feature 'User sign up' do
  scenario 'I can sign up as a new user with valid passsword confirmation' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, user_name@email.com')
    expect(User.first.email).to eq('user_name@email.com')
  end

  scenario 'Invalid password confirmation' do
    expect { sign_up(password_confirmation: 'abc') }.not_to change(User, :count)
    expect(page).to have_content('Password does not match')
  end

  scenario "I can't sign up without an email address" do
    expect { sign_up(email: nil) }.not_to change { User.count }
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email must not be blank')
  end

  scenario "I can't sign up with an invalid email address" do
    expect { sign_up(email: 'invalid@email') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'I cannot sign up with an existing email' do
    sign_up
    expect { sign_up }.to_not change { User.count }
    expect(page).to have_content('Email is already taken')
  end
end
