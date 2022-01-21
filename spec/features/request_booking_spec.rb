feature 'User can request to book' do
  scenario 'can request a booking' do
    may_signup_goto_spaces
    click_button 'Add space'
    fill_in 'space_name', with: 'Seaside Space'
    fill_in 'space_description', with: 'The perfect space for a getaway'
    fill_in 'space_price', with: '100'
    fill_in 'start_date', with: '2022-01-16'
    fill_in 'end_date', with: '2022-01-24'
    click_button 'List space'
    page.find('.space_click').click
    expect(page).to have_content 'Pick dates to request a booking'
    expect(page).to have_content 'Seaside Space'
    fill_in 'check_in', with: '2022-01-18'
    fill_in 'check_out', with: '2022-01-21'
    click_button 'Request to Book'
    expect(page).to have_content "Requests I've Made"
    expect(page).to have_content 'Space: Seaside Space'
  end
end
