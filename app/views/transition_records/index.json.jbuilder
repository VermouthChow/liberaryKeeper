json.key_format! camelize: :lower

json.total_amount @total_income_amount
json.transition_records do
  json.array! @records, partial: 'transition_record', as: :transition_record
end