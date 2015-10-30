post '/question/:question_id/answers/create' do
  if logged_in?
    current_question = Question.find(params[:question_id])
    current_answer = current_question.answers.new(data: params[:answer][:data],user_id: current_user.id)
    current_answer.save
    redirect '/questions'
  else
    @error_msg = "Please log in before add any answer"
    redirect to "/?error=#{@error_msg}"
  end
end

post '/answers/:answer_id/upvote' do
  question_id = Answer.find(params[:answer_id]).question_id
  new_answer_vote = AnswerVote.new(user_id: current_user.id, answer_id: params[:answer_id], votes_count: 1)

  if new_answer_vote.valid?
    new_answer_vote.save
    redirect to "/questions/#{question_id}"
  elsif current_user.answer_votes.find_by(answer_id: params[:answer_id]).votes_count == -1
    current_user.answer_votes.find_by(answer_id: params[:answer_id]).update(votes_count: 1)
    redirect to "/questions/#{question_id}"
  else
    redirect to "/questions/#{question_id}"
  end
end

post '/answers/:answer_id/downvote' do
  question_id = Answer.find(params[:answer_id]).question_id
  new_answer_vote = AnswerVote.new(user_id: current_user.id, answer_id: params[:answer_id], votes_count: -1)
  if new_answer_vote.valid?
    new_answer_vote.save
    redirect to "/questions/#{question_id}"
  elsif current_user.answer_votes.find_by(answer_id: params[:answer_id]).votes_count == 1
    current_user.answer_votes.find_by(answer_id: params[:answer_id]).update(votes_count: -1)
    redirect to "/questions/#{question_id}"
  else
    redirect to "/questions/#{question_id}"
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
