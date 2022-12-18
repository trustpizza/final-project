class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
    @user = User.find(params[:user_id])
  end
  

  def new
    @friendship = Friendship.new
  end

 
  def create
    @friendship = current_user.accepted_friendships.build(friendship_params)
    @friend_request = FriendRequest.find_by(friend_request_params)

    return unless @friendship.save
    @friend_request.destroy 
    

    # Destroy friend_request
    redirect_to request.referrer
  end

  def destroy
    @friendship = Friendship.find_by(user_id: friendship_params[:user_id],
                                    friend_id: friendship_params[:friend_id]) ||
                  Friendship.find_by(user_id: friendship_params[:friend_id],
                                    friend_id: friendship_params[:user_id])

    return unless @friendship.destroy

    redirect_to request.refferer  
  end
  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id)
  end
end