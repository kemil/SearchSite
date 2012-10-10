class UsersController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    logger.debug "here"
    @user = User.new(params[:user])
    if @user.save
    	logger.debug "ok"
    else
    	logger.debug "not ok"
    end
  end

  def update
    super
  end
end
