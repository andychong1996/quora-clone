get '/' do
  if logged_in?
    redirect to '/user/home'
  else
    unless params[:error].nil?
      @error = params[:error]
    end
    erb :"static/index", layout: :login_signup_layout
  end
end

post '/login' do
  @current_user = User.authenticate(params['user']['email'], params['user']['password'])
  if @current_user != nil
    session[:user_id] = @current_user.id
    redirect to '/user/home'
  else
    @error_msg = "email and password doesn't matched or account doesn't exist!"
    redirect to "/?error=#{@error_msg}"
  end
end

get '/logout' do
    session[:user_id] = nil
    redirect to '/'
end
