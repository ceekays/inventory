# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bims_session',
  :secret      => '63870bc0a91df3c441b50973bf0f15fae4616645a3c0e7d4dd554945a7810240cd1e8005029915eacab0707c63e08670572005d009a555ba7f2d01b3b49f93e3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
