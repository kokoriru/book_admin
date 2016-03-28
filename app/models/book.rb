class Book < ActiveRecord::Base
  scope :costly, -> { where("price > ?", 3000) }
  scope :written_about, -> { where("name like ?", "%#{theme}%") }

  belongs_to :publisher

  has_many :book_authors
  has_many :authors, through: :book_authors
end
