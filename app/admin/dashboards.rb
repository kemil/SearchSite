ActiveAdmin::Dashboards.build do

	section "Yachts" do
		ul do
			Boat.last(10).collect do |boat|
				li link_to(boat.name, admin_boat_path(boat))
			end
		end
	end

	section "Trips" do
		ul do
			Trip.last(10).collect do |trip|
				li link_to(trip.identifier, admin_trip_path(trip))
			end
		end
	end

  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
