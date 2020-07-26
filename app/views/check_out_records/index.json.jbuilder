json.key_format! camelize: :lower

json.check_out_records do
  json.array! @records, partial: 'check_out_record', as: :check_out_record
end