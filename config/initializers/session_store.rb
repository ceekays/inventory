# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bims_session',
  :secret      => '88559d4ef5313f283588fd9736edfb6a7cd980e8aa2291f5cb46b8f8397913d09aea71cb2a1622084da84e78e6f91e5a8130cde5bbc552a65994a7b3d3640917'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
