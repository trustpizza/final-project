class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.ordered
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path
      flash[:notice]='Post was created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
    flash[:alert] = 'Post Deleted'
  end

  def edit
    @post = Post.find(params[:id])
    @post.update(post_params)
  end

  private

  def post_params
    params.require(:post).permit(:body, :title)
  end
end
