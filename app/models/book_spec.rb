require "rails_helper"

RSpec.describe Book, type: :model do
  it "is valid with a title" do
    book = Book.new(title: "The Great Gatsby")
    expect(book).to be_valid
    expect(book.save).to be true
  end

  it "is invalid without a title" do
    book = Book.new(title: nil)
    expect(book).not_to be_valid
    expect(book.save).to be false
    expect(book.errors[:title]).to include("can't be blank")
  end
end
