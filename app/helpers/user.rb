helpers do

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def questions_answered
    current_user = User.find(session[:user_id])
    return Question.where(id: current_user.answers.pluck(:question_id))
  end

end
