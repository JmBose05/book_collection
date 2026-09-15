require "rails_helper"

RSpec.describe "Books", type: :request do
  it "creates a book with a title and shows the success notice" do
    expect {
      post books_path, params: { book: { title: "The Great Gatsby" } }
    }.to change(Book, :count).by(1)

    expect(response).to redirect_to(Book.last)
    follow_redirect!
    expect(flash[:notice]).to eq("Book was successfully created.")
  end

  it "does not create a book with a blank title" do
    expect {
      post books_path, params: { book: { title: "" } }
    }.not_to change(Book, :count)

    expect(response).to have_http_status(:unprocessable_entity)
    expect(flash[:notice]).to be_nil
  end
end