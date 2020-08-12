# frozen_string_literal: true

puts 'Seeding Roles'

roles = %w[user admin owner]

roles.each do |role|
  seed Role, name: role
end

puts
