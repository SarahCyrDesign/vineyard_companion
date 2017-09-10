class WinesController < ApplicationController

  get '/wines' do
     if logged_in?
       @wines = Wine.all
       erb :'/wines/index'
     else
       flash[:message] = "Please login to continue"
       redirect to '/login'
     end
  end


  get '/wines/new' do
    if logged_in?
      erb :'/wines/new'
    else
      flash[:message] = "Please login to continue"
      redirect to '/login'
    end
  end


  post '/wines' do
    redirect to '/' if !session[:user_id]
    flash[:message] = "Please login to continue"

    @wine = Wine.find_by(name: params[:wine][:name], user_id: current_user.id)
      if !@wine.nil?
        flash[:message] = "This wine already exists"
        redirect to 'wines/new'
      else
        @wine = Wine.new(params[:wine])
      end
    @wine.user_id = User.find(session[:user_id]).id
    if params[:wine][:vineyard_id].nil? && !params[:vineyard][:name].empty?
      # checking id vineyard already exists and checks with current_user id
      @vineyard = Vineyard.find_by(name: params[:vineyard][:name], user_id: current_user.id)
        if @vineyard.nil?
          @wine.vineyard = Vineyard.new(params[:vineyard])
          @wine.vineyard.user_id = current_user.id
        else
          flash[:message] = "This vineyard already exists"
          redirect to 'wines/new'
        end
    end
    if @wine.save
      flash[:message] = "Successfully Added"
      redirect to "wines/#{@wine.id}"
    else
      redirect to "wines/new"
    end
  end


  get '/wines/:id' do
    if logged_in?
      @wine = Wine.find_by_id(params[:id])
      erb :'/wines/show'
    else
      flash[:message] = "Please login to continue"
      redirect '/login'
    end
  end


  get '/wines/:id/edit' do
    if logged_in?
      @wine = Wine.find_by_id(params[:id])
      if @wine.user_id == current_user.id
        erb :'/wines/edit'
      else
        flash[:message] = "You cannot edit another User's Wine"
        redirect to '/wines'
      end
    else
      flash[:message] = "Please login to continue"
      redirect to '/login'
  end
end


patch '/wines/:id' do
  redirect to '/' if !session[:user_id]
  flash[:message] = "Please login to continue"

    @wine = Wine.find_by_id(params[:id])
    if params[:wine][:vineyard_id].nil? && !params[:vineyard][:name].empty?

      @vineyard = Vineyard.find_by(name: params[:vineyard][:name], user_id: current_user.id)
        if @vineyard.nil?
          @wine.vineyard = Vineyard.new(params[:vineyard])
          @wine.vineyard.user_id = current_user.id
        else
          flash[:message] = "This vineyard already exists"
          redirect to "/wines/#{@wine.id}/edit"
        end
    end
    if @wine.save
      flash[:message] = "Successfully updated"
      redirect to "wines/#{@wine.id}"
    else
      redirect to "/wines/#{@wine.id}/edit"
    end
  end


  delete '/wines/:id' do
    if logged_in? && current_user
      @wine = Wine.find_by_id(params[:id])
      if @wine.user_id == current_user.id
        @wine.delete
        flash[:message] = "Wine is now deleted"
        redirect to '/wines'
      else
        flash[:message] = "You cannot delete another User's Wine"
        redirect to '/wines'
      end
     else
       flash[:message] = "Please login to continue"
      redirect to '/login'
     end
  end
end
