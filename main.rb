require 'sinatra'

class AutomationInPracticeApp < Sinatra::Base
  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
  end

  get '/' do
    erb :home
  end
end