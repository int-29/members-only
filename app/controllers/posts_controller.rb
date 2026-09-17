class PostsController < ApplicationController
  before_action :require_login, only: [ :create, :new ]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(allowed_post_params)
    if @post.save
      flash[:succes] = "Post created"
    else
      flash.now[:alert] = "Something went wrong..."
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.all
  end

  private

  def require_login
    if current_user.logged_in?
      render :new
    else
      redirect_to login_path
    end
  end

  def allowed_post_params
    params.expect(post: [ :title, :body, :user_id ])
  end
end
