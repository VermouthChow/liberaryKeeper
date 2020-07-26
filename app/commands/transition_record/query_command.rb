class TransitionRecord::QueryCommand
  prepend SimpleCommand

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    records = TransitionRecord.includes(:user, :book)

    records = records.public_send(params[:transition_type].to_sym) if params[:transition_type]
    records = records.where('books.isbn in (?)') if params[:isbns].present?
    records = records.where(book_id: params[:book_ids]) if params[:book_ids].present?
    records = records.where(user_id: params[:user_ids]) if params[:user_ids].present?
    records = records.where('transition_records.transition_time >= ?', params[:start_time]) if params[:start_time]
    records = records.where('transition_records.transition_time <= ?', params[:end_time]) if params[:end_time]

    records
  end
end