require 'sinatra'

get '/' do
  erb :index
end

post "/" do
  @user_name = params[:user_name]
  @phone     = params[:phone]
  @date_time = params[:date_time]

  @title = 'Thank you'
  @message = "Thank you, #{@user_name}, we'll be waiting!"

  f = File.open './public/users.txt', 'a'
  f.write "User: #{@user_name}, Phone: #{@phone}, Date and time: #{@date_time}"
  f.close

  erb :message
end


