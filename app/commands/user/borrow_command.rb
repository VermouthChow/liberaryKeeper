class User::BorrowCommand
  prepend SimpleCommand

  attr_reader :user, :book_ids, :books, :account

  def initialize(user, book_ids)
    @user = user
    @book_ids = book_ids
    @books = Book.where(id: book_ids)
    @account = user.account
  end

  def call
    message = check_available
    return { message: message } if message

    ActiveRecord::Base.transaction do
      freeze_amount!
      books.each { |book| create_borrowing_record!(book, Time.current) }

      { books: books }
    end
  end

  private

  def freeze_amount!
    account.frozen_amount += books.total_rent
    account.save!
  end

  def create_borrowing_record!(book, time)
    book.check_out_records.create!(status: :lend, user: user, lend_at: time)
  end

  def check_available
    case
    when books.count(1) != book_ids.count
      "no suck books with ids: #{ (book_ids - books.ids).join(', ') }"
    when rented_books.exists?
      "books: #{ rented_books.pluck(:name).join(', ') } is check out" 
    when (account.amount - account.frozen_amount) < books.total_rent
      "the available amount #{ available_amount } of current account is not enough"
    else
      nil
    end
  end

  def rented_books
    CheckOutRecord.lend.where(book: books)
  end
end