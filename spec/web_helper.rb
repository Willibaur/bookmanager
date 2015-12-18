def create_link_BBC
  visit "links/new"
  fill_in 'Name', with: 'BBC'
  fill_in 'url', with: 'http://bbc.co.uk'
  fill_in 'tags', with: 'bubbles'
  click_button 'Add'
end

def create_link_BBC_3_tags
  visit "links/new"
  fill_in 'Name', with: 'BBC'
  fill_in 'url', with: 'http://bbc.co.uk'
  fill_in 'tags', with: 'bubbles news media'
  click_button 'Add'
end

def sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email,    with: 'alice@example.com'
  fill_in :password, with: 'oranges'
  fill_in :password_confirmation, with: 'oranges'
  click_button 'Sign up'
end

def invalid_sign_up
  visit '/users/new'
  expect(page.status_code).to eq(200)
  fill_in :email,    with: 'user@example.com'
  fill_in :password, with: '123456'
  fill_in :password_confirmation, with: '654321'
  click_button 'Sign up'
end
