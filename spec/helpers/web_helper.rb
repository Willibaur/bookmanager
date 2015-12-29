def create_link_bbc
  visit 'links/new'
  fill_in 'Name', with: 'BBC'
  fill_in 'url', with: 'http://bbc.co.uk'
  fill_in 'tags', with: 'bubbles'
  click_button 'Add'
end

def create_link_bbc_3_tags
  visit 'links/new'
  fill_in 'Name', with: 'BBC'
  fill_in 'url', with: 'http://bbc.co.uk'
  fill_in 'tags', with: 'bubbles news media'
  click_button 'Add'
end
