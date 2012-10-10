module BoatsHelper
  
  def boat_info_link(obj, title, htmlclass=nil)
    link_to title.html_safe, boat_info_url(obj), :class=>htmlclass
  end

  def boat_info_url(obj)
    if !params[:pickup].blank? && !params[:return].blank?
      pickup_date = Date.parse(params[:pickup])
      return_date = Date.parse(params[:return])
    end
    
    if !pickup_date.nil? && !return_date.nil?
      show_with_date_yacht_path(:permalink => obj.permalink, :from => pickup_date, :to =>return_date)
    else
      show_yacht_path(:permalink => obj.permalink)
    end
  end

  
end
