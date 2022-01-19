# feature 'Property owner can view requests to book' do
#   scenario 'can view request for one night' do
#     visit '/spaces'
#     click_button 'Add space'
#     fill_in 'space_name', with: 'Seaside Space'
#     fill_in 'space_description', with: 'The perfect space for a getaway'
#     fill_in 'space_price', with: '100'
#     click_button 'List space'
#     click_link 'View this space'
#     expect(page).to have_content 'Pick a date to book'
#     expect(page).to have_content 'Seaside Space'
#     fill_in 'date', with: '18/01/2022'
#     click_button 'Request to Book'
#     expect(page).to have_content 'Request for: Seaside Space'
    
#     # confirm_request
#     click_button 'Confirm Request to Book'
#     expect(page).to have_button 'Confirm Request to Book'

#     # deny_request
#     click_button 'Deny Request to Book'
#     expect(page).to have_button 'Deny Request to Book'
#   end
# end