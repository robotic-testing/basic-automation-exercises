# frozen_string_literal: true

require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/namespace'
require 'sinatra/json'

class BaseController < Sinatra::Base
  helpers Sinatra::ContentFor
  register Sinatra::Namespace

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
  end
end
