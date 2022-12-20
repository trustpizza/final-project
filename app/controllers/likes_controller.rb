class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(like_params[:post_id])
    @like = @post.likes.create(like_params)

    respond_to  do |format|
      if @like
        format.turbo_stream
        format.html { redirect_to @like }
        #debugger
      else
        redirect_to root_path
      end
  
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(like_params)
    #debugger
    
    respond_to do |format|
      if @like.destroy
        format.turbo_stream
        format.html {redirect_to @like }
      else
        redirect_to root_path
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end