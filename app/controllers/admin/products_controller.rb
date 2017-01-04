class Admin::ProductsController < ApplicationController
  before_action :verify_admin
  before_action :load_all_leaf_categories

  def new
    @product = Product.new
  end

  def index
    @products = Product.order(created_at: :DESC).paginate per_page:
      Settings.per_page.users, page: params[:page]
  end

  def show
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t("flash.danger.invalid_user")
      redirect_to root_url
    end
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".create_product_success"
    else
      flash[:danger] = t ".create_product_fail"
    end
    redirect_to request.referer
  end

  def edit
    @product = Product.find_by id: params[:id]
  end
  
  def update
    if @product.update_attributes(product_params)
      # Handle a successful update.
      flash[:success] = t "product_update"
    else
      flash[:danger] = t "product_fails"
    end
    redirect_to request.referer
  end

  def destroy
    product = Product.find_by id: params[:id]
    if product.destroy
      flash[:success] = t ".product_delete"
    else
      flash[:danger] = t ".product_not_found"
    end
    redirect_to request.referer
  end

  private
  def product_params
    params.require(:product).permit :name, :description, :image, :quantity,
     :price, :category_id
  end

  def load_all_leaf_categories
    @categories_leaf = Category.all.reject {|category| }
  end
end
