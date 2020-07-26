json.key_format! camelize: :lower

json.book do
  json.partial! @book, as: :book
  json.current_check_out do
    json.partial! "/check_out_records/check_out_record", check_out_record: @book.current_check_out
  end
end