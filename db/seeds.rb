# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create an admin user for testing
admin_user = User.find_or_create_by(email: 'admin@bakery.com') do |user|
  user.name = 'Admin User'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = 'admin'
end

# Also make any existing user with your email an admin
existing_user = User.find_by(email: 'haseebarif1285@gmail.com')
if existing_user
  existing_user.update(role: 'admin')
  puts "Made #{existing_user.email} an admin"
end

puts "Admin user created/updated: #{admin_user.email}"
puts "Admin status: #{admin_user.admin?}"

# Create default categories
categories = [
  { name: 'Cakes', description: 'Delicious cakes for all occasions' },
  { name: 'Bread', description: 'Fresh baked bread and loaves' },
  { name: 'Pastries', description: 'Sweet and savory pastries' },
  { name: 'Cookies', description: 'Crispy and chewy cookies' },
  { name: 'Pies', description: 'Traditional pies and tarts' }
]

categories.each do |category_data|
  category = Category.find_or_create_by(name: category_data[:name]) do |cat|
    cat.description = category_data[:description]
  end
  puts "Created/found category: #{category.name}"
end
