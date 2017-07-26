feature 'add more than one tag' do
  scenario 'new link' do
    add_new_link('Google', 'www.google.com', 'search cool')
    expect(page).to have_content('Google (www.google.com). Tags: search, cool')
  end
end
