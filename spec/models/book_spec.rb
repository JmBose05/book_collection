require "rails_helper"

RSpec.describe Book, type: :model do
  let(:valid_attributes) do
    {
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      price: 12.99,
      published_date: Date.new(1925, 4, 10)
    }
  end

  it "is valid with a title" do
    book = Book.new(valid_attributes)
    expect(book).to be_valid
    expect(book.save).to be true
  end

  it "is invalid without a title" do
    book = Book.new(valid_attributes.merge(title: nil))
    expect(book).not_to be_valid
    expect(book.save).to be false
    expect(book.errors[:title]).to include("can't be blank")
  end

  it "requires an author" do
    book = Book.new(valid_attributes.merge(author: nil))

    expect(book).not_to be_valid
    expect(book.errors[:author]).to include("can't be blank")
  end

  it "requires a non-negative numeric price" do
    book = Book.new(valid_attributes.merge(price: -1))

    expect(book).not_to be_valid
    expect(book.errors[:price]).to include("must be greater than or equal to 0")
  end

  it "requires a published date" do
    book = Book.new(valid_attributes.merge(published_date: nil))

    expect(book).not_to be_valid
    expect(book.errors[:published_date]).to include("can't be blank")
  end
end
