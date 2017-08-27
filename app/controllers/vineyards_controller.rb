class VineyardsController < ApplicationController

  get '/vineyards' do
     if logged_in?
       @user = current_user
       @vineyards = Vineyard.all
       erb :'/vineyards/index'
     else
       redirect to '/login'
     end
  end


  get '/vineyards/new' do
    if logged_in?
      erb :'/vineyards/new'
    else
      redirect to '/login'
    end
  end


  post '/vineyards' do
    if !session[:user_id]
      redirect to '/'
    elsif !params[:name].empty? && !params[:location].empty? && !params[:phone_number].empty? && !params[:review].empty?
      @user = User.find(session[:user_id])
      @vineyard = Vineyard.create(name: params[:name], location: params[:location], phone_number: params[:phone_number], review: params[:review])
      @user.vineyards << @vineyard
      redirect to 'vineyards/#{@vineyard.id}'
    else
      redirect to 'vineyards/new'
    end
  end


  get '/vineyards/:id' do
    if logged_in?
      @vineyard = Vineyard.find_by_id(params[:id])
      erb :'/vineyards/show'
    else
      redirect '/login'
    end
  end


  get '/vineyards/:id/edit' do
    @vineyard = Vineyard.find_by_id(params[:id])
    if logged_in? && @vineyard.user_id == current_user.id
      erb :'/vineyards/edit'
    else
      redirect '/login'
    end
  end


  patch '/vineyards/:id' do
    @vineyard = Vineyard.find_by_id(params[:id])
    if !session[:user_id]
      redirect to '/'
    elsif session[:user_id] != @vineyard.user_id
      redirect to '/vineyards'
    elsif params[:name].empty? && params[:location].empty? && params[:phone_number].empty? && params[:review].empty?
      redirect to '/vineyards/#{@vineyard.id}/edit'
    else
      @vineyard.update(name: params[:name], location: params[:location], phone_number: params[:phone_number], review: params[:review])
      @vineyard.save
      redirect to '/vineyards/#{@vineyard.id}'
    end
  end

  delete '/vineyards/:id' do
    if logged_in? && current_user
      @vineyard = Vineyard.find_by_id(params[:id])
      if @vineyard.user_id == current_user.id
        @vineyard.delete
        redirect to '/vineyards'
      else
        redirect to '/vineyards'
      end
     else
      redirect to '/login'
     end
   end

end
