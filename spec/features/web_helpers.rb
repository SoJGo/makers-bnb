def may_signup_goto_spaces
  visit '/'
  fill_in 'name', with: 'May McMaker'
  fill_in 'username', with: 'MayMcMaker'
  fill_in 'email', with: 'May@example.com'
  fill_in 'password', with: 'Marbles123'
  click_button 'Join'
end
