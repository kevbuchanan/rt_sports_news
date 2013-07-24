get '/user/edit/:id' do

end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :user
end

post '/user/edit/:id' do

end

post '/user/create' do
  @user = User.create(params[:user])
  if @user.valid? 
    session[:user_id] = @user.id
    redirect to('/')
  else 
    erb :sign_in 
  end 
end

