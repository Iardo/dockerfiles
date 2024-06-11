# This is a temporary solution to seed the admin user with the following:
# user: admin
# pass: admin

admin = User.find_by(login: 'admin')
admin.password = 'admin'
# Must confirm to the password
admin.password_confirmation = 'admin'
admin.save(validate: false)
