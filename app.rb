require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml/store'
require 'sqlite3'

# configure do
#   db = get_db
#   db.execute 'CREATE TABLE IF NOT EXISTS
#     "Users"
#     (
#         "id" INTEGER PRIMARY KEY AUTOINCREMENT, 
#         "username" TEXT, 
#         "phone" TEXT, 
#         "datestump" TEXT, 
#         "barber" TEXT, 
#         "color" TEXT
#     )'
# end

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

  @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

  if @error != ''
    return erb :visit
  end

  # db = get_db
  # db.execute 'insert into 
  #   Users 
  #   (
  #     username,
  #     phone,
  #     datestamp,
  #     barber,
  #     color
  #   )
  #   values ( ?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

  erb "Ok, See you soon!"

end

def get_db
  return SQLite3::Database.new 'barbershop.db'
end

post '/contacts' do
  @email = params[:email]
  @text = params[:text]

  hs = { :email => 'Enter email', 
         :phone => 'Leave your message' }

  @error = hs.select {|key,_| params[key] == ""}.values.join(", ")

  if @error != ''
    return erb :contacts
  end

  erb "Thank you"

end
