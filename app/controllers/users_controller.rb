class UsersController < Sinatra::Base

  get '/signup' do
    if !logged_in?
      erb :'users/signup', locals: {message: "Please create an account before signing in"}
    else
      redirect to '/vineyards'
  end
end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password])
      if user.save
        session[:user_id] = user_id
        redirect to '/vineyards'
      else
        redirect to '/users/signup'
      end
  end


  get '/login' do
    if logged_in?
      redirect to '/vineyards'
    else
      erb :'/users/login'
  end
end


  post '/login' do
    user = User.find_by(:username => params[:username])
      if user && user.authentication(params[:password])
        session[:user_id] = user_id
        redirect to '/vineyards'
      else
        redirect to '/'
      end
  end


  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
