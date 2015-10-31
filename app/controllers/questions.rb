get '/question/new' do
  if logged_in?
    erb :'questions_answers/new_question'
  else
    @error_msg = "Please log in first to create question"
    redirect to "/?error=#{@error_msg}"
  end

end

post '/question/create' do
  new_question = Question.new(data: params[:question][:data], user_id: current_user.id)
  new_question.save
  redirect to '/'
end

get '/questions/:question_id' do
  @current_question = Question.find(params[:question_id])
  if logged_in?
    erb :"questions_answers/one_question"
  else
    erb :"questions_answers/one_question", layout: :visitors_layout
  end
end

get '/:user_id/questions' do
  @current_user = User.find(current_user.id)
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

post '/questions/:question_id/upvote' do
  new_question_vote = QuestionVote.new(user_id: current_user.id, question_id: params[:question_id], votes_count: 1)
  if new_question_vote.valid?
    new_question_vote.save
    redirect to "/questions/#{params[:question_id]}"
  elsif current_user.question_votes.find_by(question_id: params[:question_id]).votes_count == -1
    current_user.question_votes.find_by(question_id: params[:question_id]).update(votes_count: 1)
    redirect to "/questions/#{params[:question_id]}"
  else
    redirect to "/questions/#{params[:question_id]}"
  end
end

post '/questions/:question_id/downvote' do
  new_question_vote = QuestionVote.new(user_id: current_user.id, question_id: params[:question_id], votes_count: -1)
  if new_question_vote.valid?
    new_question_vote.save
    redirect to "/questions/#{params[:question_id]}"
  elsif current_user.question_votes.find_by(question_id: params[:question_id]).votes_count == 1
    current_user.question_votes.find_by(question_id: params[:question_id]).update(votes_count: -1)
    redirect to "/questions/#{params[:question_id]}"
  else
    redirect to "/questions/#{params[:question_id]}"
  end

end

get '/questions/:question_id/edit' do
  @current_question = Question.find(params[:question_id])
  erb :"questions_answers/edit_question"

end

put '/questions/:question_id' do
  current_question = Question.find(params[:question_id])
  current_question[:data] = params[:data]
  if current_question.save
    redirect to '/'
  else
    redirect to "/questions/#{current_question.id}/edit"
  end
end

delete '/questions/:question_id' do
  Question.find(params[:question_id]).destroy
  redirect to '/'
end
