class Admin::CategoriesController < ApplicationController
   before_action :verify_admin

   def new
    @category = Category.new
  end

  def index
    @categories = Category.order(created_at: :DESC).paginate per_page:
      Settings.per_page.users, page: params[:page]
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_product_success"
    else
      flash[:danger] = t ".create_product_fail"
    end
    redirect_to request.referer
  end

  def edit
  end

  def destroy
    category = Category.find_by id: params[:id]
    if category.destroy
      flash[:success] = t ".product_delete"
    else
      flash[:danger] = t ".product_not_found"
    end
    redirect_to request.referer
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
