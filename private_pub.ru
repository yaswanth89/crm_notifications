# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")

app = PrivatePub.faye_app

app.bind(:subscribe) do |client_id, channel|
  puts "Client subscribe: #{client_id}:#{channel}"

  if /\/user\/*/.match(channel)
    p "ok ****8"
    SubscribeClient.perform_async(client_id, channel)
  end
end

# unsubscribe - offline
app.bind(:unsubscribe) do |client_id, channel|
  puts "Client unsubscribe: #{client_id}:#{channel}"
  UnsubscribeClient.perform_async(client_id)
end

# disconnect - offline
app.bind(:disconnect) do |client_id|
  puts "Client disconnect: #{client_id}"
  UnsubscribeClient.perform_async(client_id)
end

run app
