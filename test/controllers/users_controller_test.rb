require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def test_show
    user = users(:one)

    get "/api/v1/users/#{user.id}"
    result = body(response)

    assert_response :success
    assert_equal 1, result.count
    assert_equal user.id, result['user']['id']
    assert_equal user.account.id, result['user']['account']['id']
  end

  def test_create
    name = 'Alopex'
    amount = 200
    post "/api/v1/users", params: { user: { name: name, account: { amount: amount } } }
    result = body(response)

    assert_response :success
  end

  def test_borrow_books
    user, book, book1 = users(:one), books(:three), books(:four)
    account = user.account
    amount = account.amount
    frozen_amount = account.frozen_amount

    post "/api/v1/users/#{user.id}/borrow_books", params: { book_ids: [book.id, book1.id] }
    result = body(response)

    assert_response :success
    assert_equal amount, account.reload.amount
    assert_equal frozen_amount + book.rent + book1.rent, account.reload.frozen_amount
    assert book.current_check_out.lend?
  end

  def test_return_books
    user, book, book1 = users(:one), books(:three), books(:four)
    account = user.account
    amount = account.amount
    frozen_amount = account.frozen_amount

    post "/api/v1/users/#{user.id}/borrow_books", params: { book_ids: [book.id, book1.id] }
    post "/api/v1/users/#{user.id}/return_books", params: { book_ids: [book.id, book1.id] }
    result = body(response)

    assert_response :success
    assert_equal amount - book.rent - book1.rent, account.reload.amount
    assert_equal frozen_amount, account.reload.frozen_amount
    assert book.current_check_out.blank?
    assert_equal book.income_transition_records.last.amount, book.rent + book1.rent
  end
end
