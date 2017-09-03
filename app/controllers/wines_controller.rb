class WinesController < ApplicationController

  get '/wines' do
     if logged_in?
       @wines = Wine.all
       erb :'/wines/index'
     else
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

    @wine = Wine.new(params[:wine])
    @wine.user_id = User.find(session[:user_id]).id
    if params[:wine][:vineyard_id].nil? && !params[:vineyard][:name].empty?
      @wine.vineyard = Vineyard.create(params[:vineyard])
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
        redirect to '/'
      end
    else
      flash[:message] = "Please login to continue"
      redirect to '/login'
  end
end


  patch '/wines/:id' do
    @wine = Wine.find_by_id(params[:id])
    if !session[:user_id]
      redirect to '/'
    elsif session[:user_id]
      redirect to '/wines'
    elsif params[:name].empty? && params[:price_per_bottle].empty? && params[:color].empty? && params[:scent].empty? && params[:taste].empty? && params[:summary].empty? && params[:rating].empty? && params[:wine][:vineyard_id].empty?
      redirect to "/wines/#{@wine.id}/edit"
    else
      @wine.update(name: params[:name], price_per_bottle: params[:price_per_bottle], color: params[:color], scent: params[:scent], taste: params[:taste], summary: params[:summary], rating: params[:rating], vineyard_id: params[:wine][:vineyard_id])
      @wine.save
      redirect to "wines/#{@wine.id}"
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
