class Admin::UsersController < ApplicationController
  before_action :verify_admin
  
  def index
    @users = User.by_name(params[:search]).paginate per_page:
      Settings.per_pages.users, page: params[:page]
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".user_not_found"
      redirect_to request.referer
    end
  end

  def destroy
    use = User.find_by id: params[:id]
    if use.destroy
      flash[:success] = t ".user_delete"
    else
      flash[:danger] = t ".user_not_found"
    end
      redirect_to request.referer
  end
end
