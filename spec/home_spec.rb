# frozen_string_literal: true

describe 'HomePage' do
  before do
    visit '/'
  end

  it 'responds with a 200 status code' do
    expect(page.status_code).to eq(200)
    expect(page.body).to include('Automation in Practice')
  end

  it 'displays a list of exercise' do
    exercise_links = page.all(:css, '[data-testid="exercisesList"] li a')

    expect(exercise_links).not_to be_empty
  end
end
