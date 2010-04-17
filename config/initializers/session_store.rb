# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_misparadas.com_session',
  :secret      => '43c8bdfab1b0d2db4593c1b51624020977f1e0fd19dd5fd2a359a67a81a28339ba3f4f1b8617bbbf4d9c76f8706fc69fb3d4f40c193ccbfd9be33228eb220934'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
