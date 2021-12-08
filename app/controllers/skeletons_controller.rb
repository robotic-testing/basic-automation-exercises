# frozen_string_literal: true

class SkeletonsController < BaseController
  get '/skeletons' do
    erb :skeletons
  end
end
