json.key_format! camelize: :lower

json.user do
  json.partial! @user, as: :user
  json.account do
    json.partial! "/accounts/account", account: @user.account
  end
end
