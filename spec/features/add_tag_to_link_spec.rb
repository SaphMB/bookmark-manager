feature 'adding single tag to link on creation' do
  scenario 'link created' do
    add_new_link('This is Zombocom', 'http://www.zombo.com/', 'weird')
    expect(page).to have_content('This is Zombocom (http://www.zombo.com/). Tags: weird')
  end
end
