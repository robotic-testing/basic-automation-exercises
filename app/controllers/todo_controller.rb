# frozen_string_literal: true

class TodoController < BaseController
  get '/todo' do
    erb :todo
  end
end
