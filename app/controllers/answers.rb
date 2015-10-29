post '/question/:question_id/answers/create' do
  if logged_in?
    current_question = Question.find(params[:question_id])
    current_answer = current_question.answers.new(data: params[:answer][:data],user_id: session[:user_id])
    current_answer.save
    redirect '/questions'
  else
    @error_msg = "Please log in before add any answer"
    redirect to "/?error=#{@error_msg}"
  end
end
