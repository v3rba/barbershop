require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml/store'
require 'sqlite3'

def is_barber_exists? db, name
  db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers

  barbers.each do |barber|
    if !is_barber_exists? db, barber
      db.execute 'insert into Barbers (name) values (?)', [barber]
    end 
  end

end

def get_db
  db = SQLite3::Database.new 'barbershop.db'
  db.results_as_hash = true
  return db
end

before do
  db = get_db
  @barbers = db.execute 'select * from Barbers'
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS
    "Users"
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "username" TEXT,
      "phone" TEXT,
      "datestamp" TEXT,
      "barber" TEXT,
      "color" TEXT
    )'

  db.execute 'CREATE TABLE IF NOT EXISTS
    "Barbers"
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "name" TEXT
    )'

  seed_db db, ['Jessie Pinkman', 'Walter White', 'Gus Fring', 'Mike Ehrmantraut']
end

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

  db = get_db
  db.execute 'insert into
    Users
    (
      username,
      phone,
      datestamp,
      barber,
      color
    )
    values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

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

get '/showusers' do
  erb "Hello World"
end

