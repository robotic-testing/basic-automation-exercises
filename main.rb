require 'sinatra'

class AutomationInPracticeApp < Sinatra::Base
  configure do
    set :views, 'app/views'
  end

  get '/' do
    erb :home
  end
end