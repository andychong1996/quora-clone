get '/' do
  erb :"static/index"
end

post '/sign_in' do

end

get '/sign_up_form' do
  erb :"static/sign_up_form"
end

post '/create_user' do
  User.create()
end
