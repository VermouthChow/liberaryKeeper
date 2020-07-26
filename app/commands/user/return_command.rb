class User::ReturnCommand
  prepend SimpleCommand

  attr_reader :user, :book_ids, :books, :account, :note

  def initialize(user, book_ids, note)
    @user = user
    @book_ids = book_ids
    @books = Book.where(id: book_ids)
    @account = user.account
    @note = note
  end

  def call
    message = check_available
    return { message: message } if message

    ActiveRecord::Base.transaction do
      renew_account!
      time = Time.current

      books.each do |book|
        renew_borrowing_record!(book, time)
        create_balance_transition_record!(book, time)
      end

      { books: books }
    end
  end

  private

  def renew_account!
    account.frozen_amount -= books.total_rent
    account.amount -= books.total_rent
    account.save!
  end

  def renew_borrowing_record!(book, time)
    book.current_check_out.update!(status: :return, return_at: time)
  end

  def create_balance_transition_record!(book, time)
    book.transition_records.create!(amount: books.total_rent, 
                                    transition_type: :income, 
                                    user: user, 
                                    note: note, 
                                    transition_time: time)
  end

  def check_available
    if books_lend_by_others.exists?
      "books #{ books_lend_by_others.pluck(:name).join(', ') } not borrowing by the user"
    else
      nil
    end
  end

  def books_lend_by_others
    books.joins(:current_check_out).where.not('check_out_records.user_id = ?', user.id)
  end
end