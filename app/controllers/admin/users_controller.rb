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







