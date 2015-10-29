get '/question/new' do
  if logged_in?
    erb :'questions_answers/new_question'
  else
    @error_msg = "Please log in first to create question"
    redirect to "/?error=#{@error_msg}"
  end

end

post '/question/create' do
  new_question = Question.new(data: params[:question][:data], user_id: session[:user_id])
  new_question.save
  redirect to '/'
end

get '/questions/:question_id' do
  @current_question = Question.find(params[:question_id])
  erb :"questions_answers/one_question"
end

get '/:user_id/questions' do
  @current_user = User.find(params[:user_id])
  erb :"questions_answers/user_questions"
end

get'/:user_id/questions_answered' do
  if logged_in?
    @questions = questions_answered
    erb :"questions_answers/questions_answered_by_user"
  else
    @error_msg = "Please log in to see your answered questions"
    redirect to "/?error=#{@error_msg}"
  end
end
