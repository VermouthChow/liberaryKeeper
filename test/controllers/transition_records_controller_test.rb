require 'test_helper'

class TransitionRecordsControllerTest < ActionDispatch::IntegrationTest
  def test_index_income_perpage_1
    book = books(:one)

    params = { book_ids: [book.id], transition_type: 'income', start_time: '2019-01-09', end_time: '2020-12-12', page: 1, per_page: 1 }
    get "/api/v1/transition_records", params: params
    result = body(response)

    assert_response :success
    assert_equal result['totalAmount'].to_f, book.income_transition_records.sum(:amount).to_f
    assert_equal result['transitionRecords'].count, 1
  end

  def test_index_income_perpage_10
    book = books(:one)

    params = { book_ids: [book.id], transition_type: 'income', start_time: '2019-01-09', end_time: '2020-12-12', page: 1, per_page: 100 }
    get "/api/v1/transition_records", params: params
    result = body(response)

    assert_response :success
    assert_equal result['totalAmount'].to_f, book.income_transition_records.sum(:amount).to_f
    assert_equal result['transitionRecords'].count, 2
  end
end
