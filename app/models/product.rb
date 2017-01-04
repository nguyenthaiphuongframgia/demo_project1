class Product < ApplicationRecord
  has_many :recently_vieweds, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :image, PictureUploader
  
  belongs_to :category

  validates :name,  presence: true, length: {maximum: Settings.maximum.name}
  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :category_id, presence: true

  scope :of_ids, -> ids {where id: ids}
  scope :top_order_products, -> {order "number_of_order desc"}
  scope :top_new_products, -> {order "created_at desc"}

  scope :by_category, ->category_id do
    where category_id: category_id if category_id.present?
  end


  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_by_id(row["id"]) || new
        product.attributes = row.to_hash.slice(*row.to_hash.keys)
        product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path)
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file.original_filename}"
    end
  end

  # def self.import file
  #   CSV.foreach file.path, headers: true do |row|
  #     product_hash = row.to_hash # exclude the price field
  #     product = Product.where id: product_hash[:id]
  #     if product.count == 1
  #       product.first.update_attributes product_hash.except "price"
  #     else
  #       Product.create! product_hash
  #     end # end if !product.nil?
  #   end # end CSV.foreach
  # end # end self.import(file)
 
  
  scope :by_name, ->name do   
    where "name LIKE '%#{name}%'" if name.present?
  end

  scope :by_min_price, ->min do   
    where "price >= #{min}" if min.present?
  end

  scope :by_max_price, ->max do   
    where "price <= #{max}" if max.present?
  end

  def list_users_rated_product
    User.of_ids Rating.user_ids_by_product self.id
  end

  def rated_by? user
    self.list_users_rated_product.include? user
  end

  def average_rate
    ((ratings.to_a.sum {|item| item.score}).to_f/ratings.count).
      round(Settings.default.round)
  end
end
