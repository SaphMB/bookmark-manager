feature 'filtering links by tag' do
  scenario 'can view all links tagged with bubbles' do
    add_new_link('This is Bubbles', 'http://www.bubbles.com/', 'bubbles')
    visit '/tags/bubbles'
    expect(page).to have_content('This is Bubbles (http://www.bubbles.com/)')
  end
end
