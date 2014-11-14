class Product < ActiveRecord::Base
  attr_accessor :rmb_price
  
  belongs_to :category

  has_many :pictures, dependent: :destroy

  has_many :store_products, dependent: :delete_all
  has_many :store, through: :store_products

  accepts_nested_attributes_for :pictures, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}
  }, :allow_destroy => true

  validate :price, presence: true, numericality: { only_integer: true }
  validate :name, presence: true

  after_create :add_to_store
  after_destroy :remove_from_store

  self.per_page = 12

  def dollar_price
    price/100.00.round(2)
  end
  
end
