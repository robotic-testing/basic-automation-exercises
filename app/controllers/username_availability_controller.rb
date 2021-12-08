# frozen_string_literal: true

class UsernameAvailabilityController < BaseController
  namespace '/username-availability' do
    get { erb :username_availability }

    get '/check' do
      username_allowed = !%w[admin superadmin].include?(params['username'])

      sleep 2

      json allowed: username_allowed
    end
  end
end
