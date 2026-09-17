class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :new ]

  def new
    @post = Post.new()
  end

  def create
    @post = Post.new(allowed_post_params)
    if @post.save
      flash[:succes] = "Post created"
      redirect_to :root
    else
      flash.now[:alert] = "Something went wrong..."
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.all
  end

  private

  def allowed_post_params
    params.expect(post: [ :title, :body, :user_id ])
  end
end
