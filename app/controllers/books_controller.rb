class BooksController < ApplicationController

  def show
    book
  end

  def create
    @book = Book.create!(create_params)
  end

  def check_out_detail
    books = Book.where(isbn: params[:isbn])
    @available_books = books.available
    @check_out_books = books.check_out
  end

  private

  def book
    @book ||= Book.find(params[:id])
  end

  def create_params
    params.require(:book).permit(:name, :describe, :author, :isbn, :category, :issue_at, :purchase_at, :group_id, :series_book_id, :rent)
  end
end
