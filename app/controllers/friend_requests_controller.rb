class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @friend_requests = FriendRequest.all
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
    @friend_request = current_user.sent_friend_requests.build(friend_request_params)
    return unless @friend_request.save

    redirect_to request.referrer
  end

  def destroy
    @friend_request = FriendRequest.find_by(friend_request_params)
    return unless @friend_request.destroy

    redirect_to request.referrer
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :receiver_id)
  end
end
