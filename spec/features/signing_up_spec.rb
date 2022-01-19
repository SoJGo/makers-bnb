feature 'Signing up' do
  scenario 'a user can join Makers BnB' do
    visit '/'
    fill_in 'name', with: 'May McMaker'
    fill_in 'username', with: 'MayMcMaker'
    fill_in 'email', with: 'May@example.com'
    fill_in 'password', with: 'Marbles123'
    click_button 'Join'

    expect(page).to have_content 'Welcome, MayMcMaker!'
  end
end
