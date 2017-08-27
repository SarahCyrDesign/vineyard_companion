class WinesController < ApplicationController

  get '/wines' do
     if logged_in?
       @user = current_user
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
      redirect to '/login'
    end
  end



  post '/wines' do
    if !session[:user_id]
      redirect to '/'
    elsif !params[:name].empty?
      @user = User.find(session[:user_id])
      @wine = Wine.create(name: params[:name], price_per_bottle: params[:price_per_bottle], type: params[:type], scent: params[:scent], taste: params[:taste], summary: params[:summary], rating: params[:rating])
      @user.wines << @wine
      redirect to 'wines/#{@wine.id}'
    else
      redirect to 'wines/new'
    end
  end


  get '/wines/:id' do
    if logged_in?
      @wine = Wine.find_by_id(params[:id])
      erb :'/wines/show'
    else
      redirect '/login'
    end
  end


  get '/wines/:id/edit' do
    @wine = Wine.find_by_id(params[:id])
    if logged_in? && @wine.user_id == current_user.id
      erb :'/wines/edit'
    else
      redirect '/login'
    end
  end



  patch '/wines/:id' do
    @wine = Wine.find_by_id(params[:id])
    if !session[:user_id]
      redirect to '/'
    elsif session[:user_id] != @wine.user_id
      redirect to '/wines'
    elsif params[:name].empty?
      redirect to '/wines/#{@wine.id}/edit'
    else
      @wine.update(name: params[:name], price_per_bottle: params[:price_per_bottle], type: params[:type], scent: params[:scent], taste: params[:taste], summary: params[:summary], rating: params[:rating])
      @wine.save
      redirect to '/wines/#{@wine.id}'
    end
  end


  delete '/wines/:id' do
    if logged_in? && current_user
      @wine = Wine.find_by_id(params[:id])
      if @wine.user_id == current_user.id
        @wine.delete
        redirect to '/wines'
      else
        redirect to '/wines'
      end
     else
      redirect to '/login'
     end
  end


end
