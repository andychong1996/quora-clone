get '/' do
  if logged_in?
    redirect to '/user/home'
  else
    @all_questions = Question.all
    erb :"static/visitorspage", layout: :visitors_layout
  end
end
