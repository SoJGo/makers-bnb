feature 'User can add a new space' do
  scenario 'adding a space' do
    may_signup_goto_spaces
    click_button 'Add space'
    expect(page).to have_content 'List a new Space'
  end 

  scenario 'add name of space' do
    may_signup_goto_spaces
    click_button 'Add space'
    fill_in 'space_name', with: 'Seaside Space'
    click_button 'List space'
    expect(page).to have_content 'Seaside Space'
  end 

  scenario 'add description of space' do
    may_signup_goto_spaces
    click_button 'Add space'
    fill_in 'space_description', with: 'The perfect space for a getaway'
    click_button 'List space'
    expect(page).to have_content 'The perfect space for a getaway'
  end
  
  scenario 'add price of space' do
    may_signup_goto_spaces
    click_button 'Add space'
    fill_in 'space_price', with: '100'
    click_button 'List space'
    expect(page).to have_content '100'
  end
end
