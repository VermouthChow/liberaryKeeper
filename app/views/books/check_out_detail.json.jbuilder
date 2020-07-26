json.key_format! camelize: :lower

json.available_count @available_books.count
json.check_out_count @check_out_books.count

json.check_out_books do
  json.array! @check_out_books, partial: 'books/book_with_check_out_info', as: :book
end

json.available_books do
  json.array! @available_books, partial: 'books/book', as: :book
end