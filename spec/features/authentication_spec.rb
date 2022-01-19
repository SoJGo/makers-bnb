feature 'Authentication' do
  scenario 'a user can sign in to Makers BnB' do
    User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

    visit '/'
    click_button 'Sign In'
    fill_in 'email', with: 'May@example.com'
    fill_in 'password', with: 'Marbles123'
    click_button 'Sign In'

    expect(page).to have_content 'Welcome, MayMcMaker'
  end

  scenario 'an error displays if user gives an incorrect email' do
    User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

    visit '/'
    click_button 'Sign In'
    fill_in 'email', with: 'Moy@eximple.com'
    fill_in 'password', with: 'Marbles123'
    click_button 'Sign In'

    expect(page).not_to have_content 'Welcome, MayMcMaker'
    expect(page).to have_content "Something wasn't right! Try again..."
  end

  scenario 'an error displays if user gives an incorrect password' do
    User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

    visit '/'
    click_button 'Sign In'
    fill_in 'email', with: 'May@example.com'
    fill_in 'password', with: 'Yoyos123'
    click_button 'Sign In'

    expect(page).not_to have_content 'Welcome, MayMcMaker'
    expect(page).to have_content "Something wasn't right! Try again..."
  end

  scenario 'a user can sign out' do
    User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')
    
    visit '/'
    click_button 'Sign In'
    fill_in 'email', with: 'May@example.com'
    fill_in 'password', with: 'Marbles123'
    click_button 'Sign In'
    
    click_button 'Sign Out'
    
    expect(page).not_to have_content 'Welcome, MayMcMaker'
    expect(page).to have_content 'Bye for now. Come back soon!'
  end  
end
