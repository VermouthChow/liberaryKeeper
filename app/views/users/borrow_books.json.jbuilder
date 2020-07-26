json.key_format! camelize: :lower

if @message.present?
  json.message @message
else
  json.user do
    json.partial! @user, as: :user
  end

  json.books do
    json.array! @books, partial: 'books/book', as: :book
  end
end