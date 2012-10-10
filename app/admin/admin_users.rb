ActiveAdmin.register AdminUser do
	menu :label => 'Admin Users', :priority => 200, :parent => 'System'

  filter :email
  filter :last_sign_in_at
  filter :last_sign_in_ip
  filter :updated_at

	member_action :reset_password, :method => :get do
      user = AdminUser.find(params[:id])
      user.send_reset_password_instructions
      redirect_to :action => :show, :notice => "Reset password instructions sent"
    end

	action_item only:[:show] do
		link_to "Reset password", reset_password_admin_admin_user_path(admin_user)
	end
  
 	index do
		column :id, :sortable => :id
		column :email, :sortable => :email do |u|
			link_to u.email, admin_admin_user_path(u)
		end
		column :last_sign_in_at
		column :last_sign_in_ip
		column :updated_at
		default_actions
	end
   
end
