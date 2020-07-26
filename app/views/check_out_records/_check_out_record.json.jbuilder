json.key_format! camelize: :lower

json.extract! check_out_record, :id, :status, :lend_at, :return_at, :book_id, :user_id