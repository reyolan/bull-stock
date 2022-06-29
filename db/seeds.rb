
admin = User.create!(email: 'admin@stocks.com',
                        password: 'abc123',
                        password_confirmation: 'abc123',
                        confirmed_at: Time.now.utc,
                        role: 'admin')