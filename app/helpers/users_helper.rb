module UsersHelper
  if session[:user_token]
    User.find(session[:user_token])
  end
end
