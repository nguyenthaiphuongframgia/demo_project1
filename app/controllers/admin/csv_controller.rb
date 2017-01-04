class Admin::CsvController < ApplicationController
  before_action :verify_admin

  def create
    Product.import params[:file]
    redirect_to :back, notice: t(".product_imported")
  end

  def import
    Product.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end

end

