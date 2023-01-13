# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

BulkDiscount.create!(discount: Faker::Number.within(range: 1..99), qty_threshold: Faker::Number.within(range:2..50), merchant_id: 1)
BulkDiscount.create!(discount: Faker::Number.within(range: 1..99), qty_threshold: Faker::Number.within(range:2..50), merchant_id: 2)
BulkDiscount.create!(discount: Faker::Number.within(range: 1..99), qty_threshold: Faker::Number.within(range:2..50), merchant_id: 3)
BulkDiscount.create!(discount: Faker::Number.within(range: 1..99), qty_threshold: Faker::Number.within(range:2..50), merchant_id: 4)
BulkDiscount.create!(discount: Faker::Number.within(range: 1..99), qty_threshold: Faker::Number.within(range:2..50), merchant_id: 5)
