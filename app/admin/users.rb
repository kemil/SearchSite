ActiveAdmin.register User do
	menu :label => 'Users', :priority => 200, :parent => 'System'

	scope :all

	scope :normal do |user|
		user.where("principal_id is null")
	end

	scope :extranet do |user|
		user.where("principal_id is not null")
	end

  filter :email
  filter :principal
  filter :last_sign_in_at
  filter :last_sign_in_ip
  filter :updated_at

	member_action :reset_password, :method => :get do
      user = User.find(params[:id])
      user.send_reset_password_instructions
      redirect_to :action => :show, :notice => "Reset password instructions sent"
    end

	action_item only:[:show] do
		link_to "Reset password", reset_password_admin_user_path(user)
	end
  
 	index do
		column :id, :sortable => :id
		column :email, :sortable => :email do |u|
			link_to u.email, admin_user_path(u)
		end
		column :last_sign_in_at
		column :last_sign_in_ip
		column :updated_at
		default_actions
	end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :principal
    end
    f.buttons
  end
   
end
