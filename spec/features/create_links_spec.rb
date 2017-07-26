feature 'Creating links' do
  scenario 'I can create a new link' do
    add_new_link('This is Zombocom', 'http://www.zombo.com/')
    expect(page).to have_content('This is Zombocom (http://www.zombo.com/)')
  end
end
