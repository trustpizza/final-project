class AddForeignKeysToFriendRequest < ActiveRecord::Migration[7.0]
  def change
    add_reference :friend_requests, :receiver, index: true,
                  foreign_key: { to_table: :users }

    add_reference :friend_requests, :sender, index: true,
                  foreign_key: { to_table: :users }
  end
end
