class Admin::SuggestProductsController < ApplicationController
  before_action :verify_admin

  def index
    @suggest_products = SuggestProduct.
      by_name(params[:search]).paginate per_page: Settings.per_page.suggest,
        page: params[:page]
  end

  def edit
    @suggest_products = SuggestProduct.find_by id: params[:id]
  end
  
  def update
    unless params[:status].nil?
      if @suggested_product.update_attributes status: params[:status].to_i
        flash[:success] = t ".update_success"
      else
        flash[:notice] = t ".update_fail"
      end
      redirect_to admin_suggested_products_path
    end
  end

  def destroy
    suggest = SuggestProduct.find_by id: params[:id]
    if suggest.destroy
      flash[:success] = t ".product_delete"
    else
      flash[:danger] = t ".product_not_found"
    end
    redirect_to request.referer
  end
end
