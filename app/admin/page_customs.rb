ActiveAdmin.register PageCustom do
	menu :label => 'PageCustoms', :priority => 200, :parent => 'Content'

	scope :all

	scope :redirects do |pc|
		pc.where("redirect is not null and redirect != ''")
	end

	scope :pages do |pc|
		pc.where("redirect is null or redirect = ''")
	end

  filter :url
  filter :title
  filter :content
  filter :updated_at
  filter :created_at
  
 	index do
		column :id, :sortable => :id
		column :title, :sortable => :title do |u|
			link_to u.title, admin_page_custom_path(u)
		end
		column :updated_at
		default_actions
	end
   
end
