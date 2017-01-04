
n = 10
# 2.times do |n|
#   name  = "Nguyen Van canh #{n+1}"
#   phone = "0123456789"
#   email = "examp-#{n+1}@gmail.com"
#   password = "123456"
#   password_confirmation = "123456"
#   User.create!(name: name,
#     email: email,
#     password: password,
#     password_confirmation: password_confirmation,
#     phone: phone, is_admin: false, address: "da nang"
#   )
# end

# 8.times do |n|
#   name = "Oppo F#{n+1}s"
#   description = "Oppo's product. That's terrific"
#   quantity = 15 + n
#   price = 299
#   SuggestProduct.create!(
#     name: name,
#     description: description,

#     price: price,
#     category_id: 2,
#     user_id: 13
#   )
# end

4.times do |n|
  receiver_name = "Nguyen Van b#{n+1}"
  receiver_address = "da nang c #{n+1}"
  receiver_phone = "012223#{n+1}"
  Order.create!(
    receiver_name: receiver_name,
    receiver_address: receiver_address,
    receiver_phone: receiver_phone,
    user_id: 13,
    created_at: "2017-1-2 00:0#{n}:00",
    updated_at: "2017-1-2 00:0#{n}:00"
  )
end
