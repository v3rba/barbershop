require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml/store'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified by <a href=\"https://github.com/v3rba\">Verba</a>"
end

get '/about' do
  erb :about
end

get '/contacts' do
  erb :contacts
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]

  hh = { :username => 'Enter name', 
         :phone => 'Enter phone', 
         :datetime => 'Enter date and time' }

  # for each pair key-value
  hh.each do |key, value|

    if params[key] == ''
      @error = hh[key]
      return erb :visit
    end
  end

  erb "See you soon!"

end
