feature 'adding single tag to link on creation' do
  scenario 'link created' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    fill_in 'tag', with: 'weird'
    click_button 'Add link'
    expect(page).to have_content('This is Zombocom (http://www.zombo.com/). Tags: weird')
  end
end
