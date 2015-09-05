# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"
require 'sqlite3'

# Open a SQLite 3 database file
db = SQLite3::Database.new 'db/development.sqlite3'


Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")

app = PrivatePub.faye_app

app.bind(:subscribe) do |client_id, channel|

  puts "Client subscribe: #{client_id}:#{channel}"

  user_id = channel.split("/").last

  t = Time.now.to_s

  db.execute 'insert into active_users (user_id,created_at,updated_at) values (?,?,?)', user_id, t, t

  if /\/user\/*/.match(channel)
    p "ok ****8"
    SubscribeClient.perform_async(client_id, channel)
  end
end

# unsubscribe - offline
app.bind(:unsubscribe) do |client_id, channel|
  puts "Client unsubscribe: #{client_id}:#{channel}"

  user_id = channel.split("/").last
  db.execute 'DELETE FROM active_users WHERE user_id = ?',user_id
  
  UnsubscribeClient.perform_async(client_id)
end

run app
