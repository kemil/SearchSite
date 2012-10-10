ActiveAdmin.register Translation do
  menu :label => 'Translation', :priority => 100, :parent => 'Content'
  
  filter :key
  filter :value
  filter :locale
  
  index do		
		column :key, :sortable => :key do |tr|
			link_to tr.key, admin_translation_path(tr)
		end
	  column :locale, :sortable => :locale
		column :value, :sortable => :value do |tr|
			link_to truncate(tr.value, :length => 20), admin_translation_path(tr)
		end
    default_actions
	end

	form do |f|
		f.inputs "Translation" do
			f.input :value
			f.input :locale
			f.input :key
		end

  	
  	f.buttons

	end
end
