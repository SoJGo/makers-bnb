feature 'User can add a new space' do
  scenario 'adding a space' do
    visit '/spaces'
    click_button 'Add space'
    expect(page).to have_content 'Test Space'
  end 
end
