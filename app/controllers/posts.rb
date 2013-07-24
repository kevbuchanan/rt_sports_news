get '/post/new' do 
  if logged_in? 
    erb :new_post
  else 
    redirect to("/login")
  end
end

get '/post/edit/:id' do

end

get 'post/:id/comment' do

end

get "/post/:id" do 
  @post = Post.find(params[:id])
  erb :post
end

get '/reply/:comment_id' do
  @comment = Comment.find(params[:comment_id])
  erb :_new_comment
end

post '/post/new' do
  params[:post][:user_id] = current_user.id
  @post = Post.create(params[:post])
  if @post.valid?
    redirect to("/post/#{@post.id}")
  else
    erb :new_post
  end
end

post '/post/edit/:id' do

end

post '/post/delete/:id' do

end

post '/post/:id/comment' do
  if logged_in?
    params[:comment][:user_id] = current_user.id
    params[:comment][:post_id] = params[:id]
    @comment = Comment.create(params[:comment])
    redirect to("/post/#{params[:id]}")
  else
    redirect to('/login')
  end
end

post '/reply/:comment_id' do
  if logged_in?
    @parent = Comment.find(params[:comment_id])
    params[:comment][:user_id] = current_user.id
    params[:comment][:parent_id] = @parent.id
    params[:comment][:post_id] = @parent.post.id
    @reply = Comment.create(params[:comment])
    redirect to("/post/#{@parent.post.id}")
  else
    redirect to('/login')
  end
end


