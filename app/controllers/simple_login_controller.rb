# frozen_string_literal: true

class SimpleLoginController < BaseController
  get '/simple-login' do
    @submitted = !params['s'].nil? && !params['s'].empty?
    @user = params['user'] || {}

    erb :simple_login
  end
end
