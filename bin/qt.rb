require 'questrade_api'

client = QuestradeApi::Client.new(refresh_token: 'xIsE29EIa7rsNbGBlsTBlvZIl-kFFsno0', :live)
client.accounts
