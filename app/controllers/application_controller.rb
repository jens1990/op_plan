class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def edit
    @user = User.find(params[:id])
  end

  helper_method :admin?

  protected

  def admin_user
    unless admin?
      flash[:error] = "access only for administrators"
      redirect_to root_path
      false
    end
  end

  def admin?
    current_user.admin?
  end
end
