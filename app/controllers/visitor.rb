get '/' do
  if logged_in?
    redirect to "/users/#{current_user.id}/home"
  else
    @all_questions = Question.all
    erb :"static/visitorspage", layout: :visitors_layout
  end
end
