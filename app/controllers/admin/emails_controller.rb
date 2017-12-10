class Admin::EmailsController < ApplicationController

  def index
    @resources = Email.all
  end

  def new
    @resource = Email.new
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
    @resources = Email.all
    render 'admin/emails/index'
  end

  def sent
    @resources = Email.all
    render 'admin/emails/index'
  end

  def trash
    @resources = Email.all
    render 'admin/emails/index'
  end
end
