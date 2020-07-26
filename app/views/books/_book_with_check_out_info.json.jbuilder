json.key_format! camelize: :lower

json.extract! book, :id, :name, :describe, :author, :status, :category, :issue_at, :purchase_at
json.rented book.rented?
json.current_check_out do
  json.partial! "/check_out_records/check_out_record", check_out_record: book.current_check_out
end
