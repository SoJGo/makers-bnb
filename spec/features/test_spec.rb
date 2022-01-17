feature 'Test' do
  scenario 'index says hello' do
    visit '/'
    expect(page).to have_content "Hello!"
  end
end
