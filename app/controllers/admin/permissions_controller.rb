class Admin::PermissionsController < AdminController

  def index
    @resources = Permission.all
  end


  def edit
    @resource = Permission.find(params[:id])
  end

  def update
    @resource = Permission.find(params[:id])
    @resource.update!(permission_params)
    redirect_to edit_admin_permission_path
  end

  private

  def permission_params
    params.require(:permission).permit(:description, :status)
  end
end
