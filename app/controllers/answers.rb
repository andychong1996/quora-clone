post '/question/:question_id/answers/create' do
  if logged_in?
    current_question = Question.find(params[:question_id])
    current_answer = current_question.answers.new(data: params[:answer][:data],user_id: current_user.id)
    current_answer.save
    redirect to "/questions/#{params[:question_id]}"
  else
    @error_msg = "Please log in before add any answer"
    redirect to "/?error=#{@error_msg}"
  end
end

post '/answers/:answer_id/upvote' do
  question_id = Answer.find(params[:answer_id]).question_id
  new_answer_vote = AnswerVote.new(user_id: current_user.id, answer_id: params[:answer_id], vote_type: 1)

  if new_answer_vote.valid?
    new_answer_vote.save
    redirect to "/users/#{current_user.id}/home"
  elsif current_user.answer_votes.find_by(answer_id: params[:answer_id]).vote_type == -1
    current_user.answer_votes.find_by(answer_id: params[:answer_id]).update(vote_type: 1)
    redirect to "/users/#{current_user.id}/home"
  else
    current_user.answer_votes.find_by(answer_id: params[:answer_id]).update(vote_type: 0)
    redirect to "/users/#{current_user.id}/home"
  end
end

post '/answers/:answer_id/downvote' do
  question_id = Answer.find(params[:answer_id]).question_id
  new_answer_vote = AnswerVote.new(user_id: current_user.id, answer_id: params[:answer_id], vote_type: -1)
  if new_answer_vote.valid?
    new_answer_vote.save
    redirect to "/users/#{current_user.id}/home"
  elsif current_user.answer_votes.find_by(answer_id: params[:answer_id]).vote_type == 1
    current_user.answer_votes.find_by(answer_id: params[:answer_id]).update(vote_type: -1)
    redirect to "/users/#{current_user.id}/home"
  else
    current_user.answer_votes.find_by(answer_id: params[:answer_id]).update(vote_type: 0)
    redirect to "/users/#{current_user.id}/home"
  end
end

get '/answers/:answer_id/edit' do
  @current_answer = Answer.find(params[:answer_id])
  erb :"questions_answers/edit_answer"
end

put '/answers/:answer_id' do
  current_answer = Answer.find(params[:answer_id])
  current_answer[:data] = params[:data]
  if current_answer.save
    redirect to '/'
  else
    redirect to "/answers/#{current_answer.id}/edit"
  end
end

delete '/answers/:answer_id' do
  Answer.find(params[:answer_id]).destroy
  redirect to '/'
end
