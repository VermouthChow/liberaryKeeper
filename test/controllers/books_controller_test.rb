require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  def test_show
    book = books(:one)

    get "/api/v1/books/#{book.id}"
    result = body(response)

    assert_response :success
    assert_equal 1, result.count
    assert_equal book.id, result['book']['id']
  end

  def test_create
    create_params = { 
                      book: { 
                        name: 'Programming Pearls',
                        describe: 'the describe',
                        author: 'JOn Bentley',
                        isbn: '978-7-115-35761-8',
                        issue_at: '2000-01-01',
                        purchase_at: '2019-09-01',
                        rent: 20
                      } 
                    }
    post "/api/v1/books", params: create_params
    result = body(response)

    assert_response :success
    assert result['book']['id'].present?
  end

  def test_check_out_detail
    book = books(:one)
    get "/api/v1/books/check_out_detail", params: { isbn: book.isbn }
    result = body(response)

    assert_response :success
    assert_equal result['availableCount'], 1
    assert_equal result['checkOutCount'], 1
  end
end
