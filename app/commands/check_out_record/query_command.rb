class CheckOutRecord::QueryCommand
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    records = CheckOutRecord.includes(:user, :book)

    records = records.public_send(params[:status].to_sym) if params[:status]
    records = records.where('books.isbn in (?)') if params[:isbns].present?
    records = records.where(book_id: params[:book_ids]) if params[:book_ids].present?
    records = records.where(user_id: params[:user_ids]) if params[:user_ids].present?

    records
  end
end