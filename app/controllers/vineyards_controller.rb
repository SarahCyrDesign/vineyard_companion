class VineyardsController < ApplicationController

  get '/vineyards' do
     if logged_in?
       @vineyards = Vineyard.all
       erb :'/vineyards/index'
     else
       flash[:message] = "Please login to continue"
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
    redirect to '/' if !session[:user_id]
    flash[:message] = "Please login to continue"

    # checking id vineyard already exists and checks with current_user id
    @vineyard = Vineyard.find_by(name: params[:name])
      if @vineyard.nil?
          @vineyard = Vineyard.new(params)
          @vineyard.user_id = current_user.id
      else
        flash[:message] = "This vineyard already exists"
        redirect to 'vineyards/new'
      end
      if @vineyard.save
        flash[:message] = "Successfully Added"
        redirect to "vineyards/#{@vineyard.id}"
      else
        redirect to "vineyards/new"
      end
    end


  get '/vineyards/:id' do
    if logged_in?
      @vineyard = Vineyard.find_by_id(params[:id])
      erb :'/vineyards/show'
    else
      flash[:message] = "Please login to continue"
      redirect '/login'
    end
  end


  get '/vineyards/:id/edit' do
    if logged_in?
    @vineyard = Vineyard.find_by_id(params[:id])
      if @vineyard.user_id == current_user.id
        erb :'/vineyards/edit'
      else
        flash[:message] = "You cannot edit another User's Vineyard/Winery"
        redirect to '/vineyards'
      end
    else
      flash[:message] = "Please login to continue"
      redirect to '/login'
    end
  end


  patch '/vineyards/:id' do
    if !session[:user_id]
      flash[:message] = "Please login to continue"
      redirect to '/'
    end
    @vineyard = Vineyard.find_by_id(params[:id])
    if @vineyard.update(params[:vineyard])
      flash[:message] = "Successfully updated"
      redirect to "/vineyards/#{@vineyard.id}"
    else
      flash[:message] = @vineyard.errors.full_messages.uniq.join(', ')
      redirect to "/vineyards/#{@vineyard.id}/edit"
    end
  end

  delete '/vineyards/:id' do
    if logged_in? && current_user
      @vineyard = Vineyard.find_by_id(params[:id])
      if @vineyard.user_id == current_user.id
        @vineyard.delete
        flash[:message] = "Successfully Deleted!"
        redirect to '/vineyards'
      else
        flash[:message] = "You cannot delete another User's Vineyard"
        redirect to '/vineyards'
      end
     else
      flash[:message] = "Please login to continue"
      redirect to '/login'
     end
   end

end
