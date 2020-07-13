# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if Rails.env.development?
  org = Organization.find_or_create_by! name: 'YAC'
  site = org.sites.find_or_create_by! name: 'YAC Sample', domain: ENV['PROXY_URL']

  if site.posts.count.zero?
    identifier = "post-#{SecureRandom.hex(4)}"
    10.times do
      site.posts.create! identifier: identifier
      identifier.next!
    end
  end
end


# == Rails Credential
#
aa_env = Rails.application.credentials.dig(Rails.env.to_sym, :active_admin)

# == AdminUser
#
root_admin_email = aa_env.dig(:root_user, :email)
root_admin_password = aa_env.dig(:root_user, :password)

AdminUser.create!(
  email: root_admin_email,
  password: root_admin_password,
  password_confirmation: root_admin_password
) if AdminUser.where(email: root_admin_email).empty?
