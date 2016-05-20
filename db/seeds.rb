20.times do
  User.create!(
    :email                  => Faker::Internet.email,
    :password               => "helloworld",
  )
end

30.times do
  Wiki.create!(
    :title          => Faker::Lorem.words(rand(2..10)).join(' '),
    :body           => Faker::Lorem.paragraphs(rand(2..8)).join('<br><br>')
  )
end

wikis = Wiki.all

standard = User.create(
    email:    'standard@example.com',
    password: 'helloworld',
    role:     'standard'
  )
  standard.save!

  premium = User.create(
    email:    'premium@example.com',
    password: 'helloworld',
    role:     'premium'
  )
  premium.save!

  admin = User.create(
  email:    'eggandcheesesandwich@gmail.com',
    password: 'helloworld',
    role:     'admin'
  )
  admin.save!

  users = User.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
