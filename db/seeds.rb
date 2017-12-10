# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create([ {
    user: 'superadmin',
    name: 'Superadmin',
    description: 'I am the superuser. I have no limitations. Don\'t use me on production.',
    email: 'superadmin@admin.com',
    password: 'admin'
  },
  {
    user: 'admin',
    name: 'Diseños Devilu',
    description: 'I am the main administration account. Use me when you need to administrate the app.',
    email: 'admin@admin.com',
    password: 'admin'
  },
  {
    user: 'manager',
    name: 'Manager',
    description: 'I am the manager of the app. Use me on a regular basis.',
    email: 'manager@admin.com',
    password: 'manager'
  },
  {
    user: 'user',
    name: 'Default user',
    description: 'I am the default user. Grant me no special permissions.',
    email: 'manager@admin.com',
    password: 'user'
  },
])

# Roles
Role.create([{
    name: 'Superadmin',
    slug: 'superadmin'
  },
  {
    name: 'Administrator',
    slug: 'admin'
  },
  {
    name: 'Manager',
    slug: 'manager'
  },
  {
    name: 'User',
    slug: 'user'
  }
])

# Permissions

modules = [
  'Users',
  'Roles',
  'Permissions'
];

abilities = [
  'View',
  'Create',
  'Update',
  'Delete',
];

modules.each do |m|
  abilities.each do |a|
    Permission.create([{name: m + ' ' + a, slug: (m + '_' + a).downcase, module: m}])
  end
end

# Relations
User.find(1).roles << Role.find(1)
User.find(2).roles << Role.find(2)
User.find(3).roles << Role.find(3)

Role.find(1).permissions << Permission.all
Role.find(2).permissions << Permission.all
Role.find(3).permissions << Permission.where(id: [1, 2, 3, 4])
