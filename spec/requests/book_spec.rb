require "rails_helper"

RSpec.describe "Books", type: :request do
  it "creates a book with a title and shows the success notice" do
    expect {
      post books_path, params: { book: book_attributes }
    }.to change(Book, :count).by(1)

    expect(response).to redirect_to(Book.last)
    follow_redirect!
    expect(flash[:notice]).to eq("Book was successfully created.")
  end

  it "does not create a book with a blank title" do
    expect {
      post books_path, params: { book: book_attributes.merge(title: "") }
    }.not_to change(Book, :count)

    expect(response).to have_http_status(:unprocessable_entity)
    expect(flash[:alert]).to eq("Book could not be created.")
  end

  it "shows the delete confirmation page for a book" do
    book = Book.create!(book_attributes.merge(title: "Delete Me"))

    get delete_book_path(book)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Delete Book")
    expect(response.body).to include("Delete Me")
  end

  it "saves a book author" do
    post books_path, params: { book: book_attributes }

    expect(response).to redirect_to(Book.last)
    expect(flash[:notice]).to eq("Book was successfully created.")
    expect(Book.last.author).to eq("F. Scott Fitzgerald")
  end

  it "saves a book price" do
    post books_path, params: { book: book_attributes }

    expect(response).to redirect_to(Book.last)
    expect(flash[:notice]).to eq("Book was successfully created.")
    expect(Book.last.price).to eq(BigDecimal("12.99"))
  end

  it "saves a book published date" do
    post books_path, params: { book: book_attributes }

    expect(response).to redirect_to(Book.last)
    expect(flash[:notice]).to eq("Book was successfully created.")
    expect(Book.last.published_date).to eq(Date.new(1925, 4, 10))
  end

  private

  def book_attributes
    {
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      price: "12.99",
      published_date: "1925-04-10"
    }
  end
end
