class AddNotificationemailToPrincipals < ActiveRecord::Migration
  def change
    add_column :principals, :notificationemail, :string
  end
end
