class VineyardsController < Sinatra::Base

  get '/vineyards' do
     if logged_in?
       @user = current_user
       @vineyards = Vineyard.all
       erb :'/vineyards'
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








end
