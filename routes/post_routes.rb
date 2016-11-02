require_relative '../models/post'

# -- Posts
# Show create post form
get '/posts/new' do
  # Redirect to login if not authenticated
  if !logged_in?
    redirect to '/session/new'
  end

  erb :post_new
end

# Create new post
post '/posts' do
  # Redirect to login if not authenticated
  if !logged_in?
    redirect to '/session/new'
  end

  post = Post.new
  post.title = params[:title]
  post.content = params[:content]
  post.date_posted = Time.new
  post.view_count = 0
  post.user_id = current_user.id

  if post.save
    redirect to "/posts/#{post.id}"
  else
    erb :post_new
  end
end

# Show single post
get '/posts/:id' do
  @post = Post.find_by(id: params[:id])
  if @post
    # Update view count
    @post.view_count += 1
    @post.save
    erb :post_view
  else
    @error = 'Post not found.'
    erb :error
  end
end

# Show edit post form
get '/posts/:id/edit' do
  @post = Post.find_by(id: params[:id])
  if @post
    # Redirect if not owner
    if !is_owner?(@post)
      redirect to "/posts/#{@post.id}"
    end

    erb :post_edit
  else
    @error = 'Post not found.'
    erb :error
  end
end

# Update post details
put '/posts/:id' do
  @post = Post.find_by(id: params[:id])
  if @post
    # Redirect if not owner
    if !is_owner?(@post)
      redirect to "/posts/#{@post.id}"
    end

    @post.title = params[:title]
    @post.content = params[:content]

    if @post.save
      redirect to "/posts/#{@post.id}"
    else
      erb :post_edit
    end
  else
    @error = 'Post not found.'
    erb :error
  end
end

# Delete post
delete '/posts/:id' do
  @post = Post.find_by(id: params[:id])

  if @post
    # Redirect if not owner
    if !is_owner?(@post)
      redirect to "/posts/#{@post.id}"
    else
      @post.destroy
      redirect to '/'
    end
  else
    @error = 'Post not found.'
    erb :error
  end
end
