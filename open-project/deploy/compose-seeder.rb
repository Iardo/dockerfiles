
# Wait until the Ruby REPL finish loading...
admin = User.find_by(login: 'admin')
admin.password = 'mynewpassword1234'
# Must confirm to the password
admin.password_confirmation = 'mynewpassword1234'
admin.save!
