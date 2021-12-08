# frozen_string_literal: true

class HomeController < BaseController
  get '/' do
    erb :home
  end
end
