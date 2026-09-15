class Book < ApplicationRecord
    validates :title, :author, :published_date, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    has_many :user_books
    has_many :users, through: :user_books
end
