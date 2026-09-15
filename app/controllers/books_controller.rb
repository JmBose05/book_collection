class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy delete]

  def index
    @books = Book.all
  end

  def show
  end

  def delete
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      flash.now[:alert] = "Book could not be created."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      flash.now[:alert] = "Book could not be updated."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :published_date)
  end
end
