require "common"
class Admin::ChartsController < ApplicationController
  include SharedMethods
  
  def index
  end

  private
  def get_chart_data
    current_date = get_current_monday - Settings.one.day
    Settings.weekday.times.each do |day|
      @user_accounts << User.user_count(current_date
        .strftime(Settings.date_format)).count
      @orders << Order.order_count(current_date
        .strftime(Settings.date_format)).count
      current_date = current_date - Settings.one.day
    end
    @user_accounts.reverse!
    @orders.reverse!
  end
end
