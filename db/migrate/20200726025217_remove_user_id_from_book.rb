class RemoveUserIdFromBook < ActiveRecord::Migration[5.1]
  def change
    remove_reference :books, :user, index: true
  end
end
