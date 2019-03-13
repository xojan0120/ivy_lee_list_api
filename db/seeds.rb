# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.create(title:"-----", order_number: 2) # id:1固定とする
Item.create(title:"task1", order_number: 0)
Item.create(title:"task2", order_number: 1)

ArchivedItem.create(title:"archive1", order_number: 0)
ArchivedItem.create(title:"archive2", order_number: 1)
ArchivedItem.create(title:"archive3", order_number: 2)
