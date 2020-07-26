json.key_format! camelize: :lower

json.extract! transition_record, :id, :amount, :transition_type, :note, :transition_time, :user_id, :book_id
