# admin
User.create!(email: 'admin@stocks.com',
             password: 'abc123',
             password_confirmation: 'abc123',
             confirmed_at: Time.now.utc,
             role: 0)

# approved trader
User.create!(email: 'approved.trader@stocks.com',
             password: 'abc123',
             password_confirmation: 'abc123',
             confirmed_at: Time.now.utc,
             approved: true,
             role: 1)

# not approved trader
User.create!(email: 'not.approved.trader@stocks.com',
             password: 'abc123',
             password_confirmation: 'abc123',
             confirmed_at: Time.now.utc,
             approved: false,
             role: 1)
