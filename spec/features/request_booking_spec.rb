feature 'User can request to book' do
  scenario 'can request one night' do
    visit '/spaces'
    click_button 'Add space'
    fill_in 'space_name', with: 'Seaside Space'
    fill_in 'space_description', with: 'The perfect space for a getaway'
    fill_in 'space_price', with: '100'
    click_button 'List space'
    click_link 'View this space'
    expect(page).to have_content 'Pick a date to book'
    expect(page).to have_content 'Seaside Space'
    fill_in 'date', with: '18/01/2022'
    click_button 'Request to Book'
  end
end