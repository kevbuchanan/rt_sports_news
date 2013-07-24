get '/post/new' do 
  if logged_in? 
    erb :new_post
  else 
    redirect to("/login")
  end
end

get '/post/edit/:id' do
  @post = Post.find(params[:id])
  erb :edit_post
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
  @post = current_user.posts.create(params[:post])
  if @post.valid?
    redirect to("/post/#{@post.id}")
  else
    erb :new_post
  end
end

post '/post/edit/:id' do
  @post = Post.find(params[:id])
  if logged_in? && @post.user.id == current_user.id 
    @post.update_attributes(params[:post])
    redirect to("/post/#{@post.id}")
  else
    redirect to('/login')
  end 
end

post '/post/delete/:id' do
   @post = Post.find(params[:id])
   if logged_in? && @post.user.id == current_user.id 
     @post.destroy
     redirect to('/')
   else
     redirect to('/login')
   end 
end

post '/post/:id/comment' do
  if logged_in?

    @comment = current_user.comments.build(params[:comment])
    @comment.post = Post.find(params[:id])
    @comment.save
    
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

post '/post/upvote/:id' do
  if logged_in?
    @post = Post.find_by_id(params[:id])
    @post.votes.create(user_id: current_user.id)
  end
  redirect to("/post/#{@post.id}")
end

post '/comment/upvote/:id' do
  if logged_in?
    @comment = Comment.find_by_id(params[:id])
    @comment.votes.create(user_id: current_user.id)
  end
  redirect to("/post/#{@comment.post.id}")
end 





















