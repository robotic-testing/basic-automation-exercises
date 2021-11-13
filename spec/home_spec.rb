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

  it 'visit all exercises pages' do
    all_link_hrefs = page.all(:css, '[data-testid="exercisesList"] li a').map do |element|
      element[:href]
    end

    all_link_hrefs.each do |exercise_url|
      visit exercise_url
      expect(page.status_code).to eq(200)
    end
  end
end
