class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect '/vineyards'
    else
      flash[:message] = "Please sign in to continue"
      erb :'/users/signup'
   end
 end



  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password])
      if user.save
        session[:user_id] = user.id
        redirect to '/vineyards'
      else
        flash[:message] = "Please fill in all fields"
        redirect to '/users/signup'
      end
  end


  get '/login' do
    if logged_in?
      redirect to '/vineyards'
    else
      flash[:message] = "Please create an account or enter your login info"
      erb :'/users/login'
    end
  end


  post '/login' do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to '/vineyards'
      else
        flash[:message] = "login info is incorrect, please try again"
        redirect to '/'
      end
  end


  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You are now logged out"
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
