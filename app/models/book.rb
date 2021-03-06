class Book < ActiveRecord::Base
  enum status: {resevation: 0, now_on_sale: 1, end_of_print: 2}

  scope :costly, -> { where("price > ?", 3000) }
  scope :written_about, -> { where("name like ?", "%#{theme}%") }

  belongs_to :publisher

  has_many :book_authors
  has_many :authors, through: :book_authors

  # 本に1文字以上15文字以内の名前が含まれていて、本の価格が¥0以上になっていること
  validates :name, presence: true
  validates :name, length: { maximum: 15 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # 本の名前に 'exercise' が含まれているとバリデーションエラーを返す
  validate do |book|
    if book.name.include?("exercise")
      book.errors[:name] << "I don't like exercise."
    end
  end

  # 本の名前に 'Cat' が含まれていた場合 'lovely Cat' という文字に置き換える
  before_validation :add_lovely_to_cat
  def add_lovely_to_cat
    self.name = self.name.gsub(/Cat/) do |matched|
      "lovely #{matched}"
    end
  end

  # データ削除時に削除データをログに書き込む
  after_destroy do |book|
    Rails.logger.info "Book is deleted: #{book.attributes.inspect}"
  end

  # 高価な本データ削除時に警告ログを表示
  def high_price?
    price >= 5000
  end

  after_destroy :if => :high_price? do |book|
    Rails.logger.warn "Book with high price is deleted: #{book.attributes.inspect}"
    Rails.logger.warn "Please check!!"
  end
end
