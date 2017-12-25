class Admin::EmailsController < AdminController

  def index
    @resources = current_user.emails
  end

  def new
    @resource = Email.new
  end

  def create
    @resource = Email.new(email_params.except(:recipient_ids))
    @resource.user_id = current_user.id
    @resource.status = params[:status]
    email_params[:recipient_ids].each do |r|
      @resource.recipients.build(:user_id => r)
    end
    if @resource.save
      flash[:success] = "emails_new"
      redirect_to admin_emails_path
    else
      flash[:danger] = "emails_failed"
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
    if (@resource.has_owner(current_user) && @resource.status == 1) || @resource.recipients.where(user_id: current_user.id, status: 1).present?
      if @resource.has_owner(current_user)
        @resource.status = -1
        @resource.save
      else
        @recipient = @resource.recipients.where(user_id: current_user.id).first
        @recipient.status = -1
        @recipient.save
      end
      flash[:warning] = "trash"
    else
      if @resource.status == 0
        @recipients = @resource.recipients.all
        @resource.recipients.destroy(@recipients)
        @resource.destroy
      elsif @resource.has_owner(current_user)
        @resource.status = -2
        @resource.save
      else
        @recipient = Recipient.where(user_id: current_user.id, email_id: @resource.id).first
        @recipient.status = -2
        @recipient.save
      end
      flash[:danger] = "delete"
    end
    redirect_to admin_trash_emails_path
  end

  def restore
    @resource = Email.find(params[:id])
    if @resource.has_owner(current_user)
      @resource.status = 1
      @resource.save
    else
      @recipient = Recipient.where(user_id: current_user.id, email_id: @resource.id).first
      @recipient.status = 1
      @recipient.save
    end
    flash[:info] = "restore"
    redirect_back fallback_location: admin_emails_path
  end

  # Folders
  def draft
    @resources = current_user.draft_emails
    render :index
  end

  def sent
    @resources = current_user.sent_emails
    render :index
  end

  def trash
    puts @resources = current_user.trash_emails
    render :index
  end

  private

  def email_params
    params.require(:email).permit(:subject, :body, :status, :_destroy, recipient_ids: [])
  end
end
