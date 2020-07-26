class UsersController < ApplicationController
  def show
    user
  end

  def create
    create_params = params.require(:user)
    
    ActiveRecord::Base.transaction do
      @user = ::User.create!(create_params.permit(:name)) 
      @account = ::Account.create!(create_params.require(:account).permit(:amount).merge(user: @user))
    end
  end

  def borrow_books
    result = User::BorrowCommand.call(user, params[:book_ids]).result
    @message, @books = result[:message], result[:books]
  end

  def return_books
    result = User::ReturnCommand.call(user, params[:book_ids], params[:note]).result
    @message, @books = result[:message], result[:books]
  end

  private

  def user
    @user ||= ::User.find(params[:id])
  end
end
