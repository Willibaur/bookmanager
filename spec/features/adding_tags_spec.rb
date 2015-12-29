feature 'Adding a tag' do
  # As a time-pressed user
  # So that I can organise my many links into different categories for ease
  # of search
  # I would like to tag links in my bookmark manager

  scenario 'I can add a tag to a new link' do
    create_link_bbc

    link = Link.first
    expect(link.tags.map(&:name)).to include('bubbles')
  end

  # As a time-pressed user
  # So that I can organise my links into different categories for ease of search
  # I would like to add tags to the links in my bookmark manager

  scenario 'I can add multiple tags to a new link' do
    create_link_bbc_3_tags

    link = Link.first
    expect(link.tags.map(&:name)).to include('bubbles', 'news', 'media')
  end
end
