class Admin::OrdersController < ApplicationController
  before_action :verify_admin

  def index
    @orders = Order.order(created_at: :DESC).paginate per_page:
      Settings.per_page.users, page: params[:page]
  end

  def update
    unless params[:status].nil?
      if @order.update_attributes status: params[:status].to_i
        flash[:success] = t ".update_success"
      else
        flash[:notice] = t ".update_fail"
      end
      redirect_to admin_orders_path
    end
  end
end
