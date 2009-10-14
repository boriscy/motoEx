# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_motoex_session',
  :secret      => '910220f50c1a6bdf6cb446b94edc7edc74a81f6bb466b3cd17faff22a67e7f34253adac7d8a10a1dfd6936dc87e571b1823f01d6109295e34471b82101a608ca'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
