# frozen_string_literal: true

puts 'Seeding Admins'

seed User, { email: 'jiricech94@gmail.com' },
     password: '123456789',
     first_name: 'Jiří',
     last_name: 'Čech',
     confirmed_at: DateTime.now,
     confirmation_token: 'Auto Confirmed'
puts
