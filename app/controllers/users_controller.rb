class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/vineyards'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      flash[:message] = "You are now logged in!"
      redirect to '/vineyards'
    else
      flash[:message] = user.errors.full_messages.join(', ')
      erb :'/users/signup'
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
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "You are now logged in!"
      redirect to '/vineyards'
    else
      flash[:message] = "login info is incorrect, please try again"
      redirect to '/login'
    end
  end



  get '/users/:id' do
    if logged_in?
      @user = User.find(params[:id])
      erb :'users/show'
    else
      flash[:message] = "Please create an account or enter your login info"
    redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  delete '/users/:id/delete' do
    if logged_in?
      current_user.delete
      flash[:message] = "Your account has now been deleted"
      redirect to "/"
    else
      flash[:message] = "Please create an account or enter your login info"
      redirect to '/login'
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
end
