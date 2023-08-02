# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'cpf_faker'

User.destroy_all

2.times do
  User.create!(name: Faker::Name.name,
              email: Faker::Internet.email,
              phone: "(00)0000-0000",
              cpf: Faker::CPF.pretty)
end

puts 'Seed completed'
