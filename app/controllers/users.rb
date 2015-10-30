get '/user/new' do
  erb :"static/sign_up_form", layout: :login_signup_layout
end

post '/user/create' do
  @current_user=User.new(params[:user])
  if @current_user.save
    redirect to '/'
  end
end

get '/user/profile' do
  if logged_in?
    @current_user
    erb :"users/profile"
  else
    @error_msg = "You must log-in first to view your profile!"
    redirect to "/?error=#{@error_msg}"
  end
end

get '/user/home' do
  if logged_in?
    @current_user
    @all_questions = Question.all
    erb :"users/home"
  else
    @error_msg = "Please log in first"
    redirect to "/?error=#{@error_msg}"
  end
end
