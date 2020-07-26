require 'test_helper'

class CheckOutRecordsControllerTest < ActionDispatch::IntegrationTest
  def test_index_income_perpage_1
    book = books(:one)

    params = { book_ids: [book.id], status: 'lend' }
    get "/api/v1/check_out_records", params: params
    result = body(response)

    assert_response :success
    assert_equal result['checkOutRecords'].count, 1
  end
end
