feature 'filtering links by tag' do
  scenario 'can view all links tagged with bubbles' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.bubbles.com/'
    fill_in 'title', with: 'This is Bubbles'
    fill_in 'tag', with: "bubbles"
    click_button 'Add link'
    visit '/tags/bubbles'
    expect(page).to have_content('This is Bubbles (http://www.bubbles.com/)')
  end
end
