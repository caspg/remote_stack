if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'kacper@email.com') do |admin_user|
    admin_user.password = 'password'
    admin_user.password_confirmation = 'password'
  end
end

JobOrigin::NAMES.each do |name|
  JobOrigin.find_or_create_by!(name: name)
end
