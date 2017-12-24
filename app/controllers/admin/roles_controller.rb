class Admin::RolesController < AdminController

  def index
    @resources = Role.all
  end

  def new
    @resource = Role.new
  end

  def create
    @resource = Role.new(role_params)
    @resource.permissions = Permission.where(id: role_params[:permission_ids])
    if @resource.save
      redirect_to edit_admin_role_path(@resource.id)
    else
      render "new"
    end
  end

  def edit
    @resource = Role.find(params[:id])
  end

  def update
    @resource = Role.find(params[:id])
    @resource.update(role_params)

    @resource.permissions = Permission.where(id: role_params[:permission_ids])
    @resource.save

    redirect_to edit_admin_role_path
  end

  def destroy
    @resource = Role.find(params[:id])
    @resource.destroy
    redirect_to admin_roles_path
  end

  private

  def role_params
    params.require(:role).permit(:name, :slug, :description, :status, :_destroy, permission_ids: [])
  end
end





