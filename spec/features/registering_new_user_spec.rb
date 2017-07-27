feature 'FEATURE: registering a new user' do
  scenario 'signing up dave' do
    visit '/users/new'
    fill_in 'email', with: 'dave@dave.dv'
    fill_in 'password', with: '1234dave'
    click_button 'Register'
    expect(page).to have_current_path('/links')
    expect(page).to have_content "Welcome, dave@dave.dv"
    expect(User.all.count).to eq 1
  end
end
