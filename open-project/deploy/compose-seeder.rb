admin = User.find_by(login: 'admin')
admin.password = 'admin'
# Must confirm to the password
admin.password_confirmation = 'admin'
admin.save!
