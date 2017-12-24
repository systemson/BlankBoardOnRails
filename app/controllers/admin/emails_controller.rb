class Admin::EmailsController < AdminController

  def index
    @resources = auth_user.emails
  end

  def new
    @resource = Email.new
  end

  def create
    @resource = Email.new(email_params.except(:recipient_ids))
    @resource.user_id = auth_user.id
    @resource.status = params[:status]
    email_params[:recipient_ids].each do |r|
      @resource.recipients.build(:user_id => r)
    end
    if @resource.save
      redirect_to admin_emails_path
    else
      render :new
    end
  end

  def show
    @resource = Email.find(params[:id])
  end

  def edit
    @resource = Email.find(params[:id])
  end

  def destroy
    @resource = Email.find(params[:id])
    @resource.destroy
    redirect_to admin_emails_path
  end

  # Folders
  def draft
    @resources = auth_user.draft_emails
    render :index
  end

  def sent
    @resources = auth_user.sent_emails
    render :index
  end

  def trash
    @resources = auth_user.trash_emails
    render :index
  end

  private

  def email_params
    params.require(:email).permit(:subject, :body, :status, :_destroy, recipient_ids: [])
  end
end
