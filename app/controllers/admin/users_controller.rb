class Admin::UsersController < AdminController

  def index
    @resources = User.all
  end

  def new
    @resource = User.new
  end

  def create
    @resource = User.new(user_params)
    @resource.password = 'secret'
    @resource.roles = Role.where(id: user_params[:role_ids])
    if @resource.save
      redirect_to edit_admin_user_path(@resource)
    else
      render "new"
    end
  end

  def show
    @resource = User.find(params[:id])
  end

  def edit
    @resource = User.find(params[:id])
  end

  def update
    @resource = User.find(params[:id])
    @resource.update(user_params)

    @resource.roles = Role.where(id: user_params[:role_ids])
    @resource.save

    redirect_back(fallback_location: admin_users_path)
  end

  def update_password
    @resource = User.find(params[:id])

    if(@resource.authenticate(user_params[:old_password]))
      @resource.password = user_params[:password]
      @resource.save
    end

    redirect_to edit_admin_user_path
  end

  def upload
    # Find user
    @resource = User.find(params[:id])

    # Check if user's image is set
    if (!@resource.image.nil?)
      # Delete user's image is exists
      File.delete(Rails.root.join('public', 'img', 'avatar', @resource.image)) if File.exist?(Rails.root.join('public', 'img', 'avatar', @resource.image))
    end

    # Get the user's image from request
    @image = params[:user][:image]

    # Set the image's name
    @avatar_img = token + File.extname(@image.original_filename)

    # Store the image in file system
    File.open(Rails.root.join('public', 'img', 'avatar', @avatar_img), 'wb') do |file|
      file.write(@image.read)
    end

    # Update the user's image in DB
    @resource.image = @avatar_img
    @resource.save

    # Redirect to edit user
    redirect_to edit_admin_user_path
  end

  def destroy
    @resource = User.find(params[:id])
    @resource.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:user, :name, :last_name, :description, :password, :email, :status, :image, :_destroy, role_ids: [])
  end
end
