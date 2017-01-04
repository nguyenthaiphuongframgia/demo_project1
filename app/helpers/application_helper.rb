module ApplicationHelper

  def full_title page_title
    base_title = t("project_name")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def category_select
    Category.all.map{|category| [category.name, category.id]}
  end

  def group_by_order
    column_chart Order.group_by_day_of_week(:created_at, format: "%a").count,  height: '500px', library: {
      title: {text: 'Data Order', x: -10},
      yAxis: {
         allowDecimals: false, # Chỉ hiển thị số nguyên trên trục y
         title: {
             text: 'Count Order'
         }
      },
      xAxis: {
         title: {
             text: 'Orders'
         }
      }
    }
  end

  def group_by_user
    column_chart User.group_by_day_of_week(:created_at, format: "%a").count,
      height: '500px', library: {
      title: {text: 'Data User', x: -10},
      yAxis: {
         allowDecimals: false, # Chỉ hiển thị số nguyên trên trục y
         title: {
             text: 'Count User'
         }
      },
      xAxis: {
         title: {
             text: 'Users'
         }
      }
    }
  end
end
