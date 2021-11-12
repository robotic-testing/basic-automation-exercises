require 'sinatra'
require 'sinatra/content_for'

class AutomationInPracticeApp < Sinatra::Base
  helpers Sinatra::ContentFor

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
  end

  get '/' do
    erb :home
  end

  get '/simple-login' do
    @submitted = !params['s'].nil? && !params['s'].empty?
    @user = params['user'] || {}

    erb :simple_login
  end

  get '/todo' do
    erb :todo
  end
end