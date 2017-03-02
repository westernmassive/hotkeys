#server.rb

require 'sinatra'
require "sinatra/namespace"
require 'mongoid'
require 'mongo'
require 'json'

post '/payload' do
  push = JSON.parse(request.body.read)
  puts "I got some JSON: #{push.inspect}"
end

#setup dev db
Mongoid.load! "mongoid.config"

#Models
class HotKey
  include Mongoid::Document


  field :subject, type: String
  field :result, type: String
  field :WindowsCombo, type: String
  field :MacCombo, type: String


  validates :subject, presence: true
  validates :result, presence: true
  validates :WindowsCombo, presence: true
  validates :MacCombo, presence: true

  index({ result: 'text' })
  index({ MacCombo:1 }, { unique: true, name: "hotkey_index" })

end

#Endpoint
# get '/'

# namespace '/api/v1' do

  before do
    content_type 'application/json'
  end

  get '/' do
     HotKey.all.to_json
    # HotKeys.map { |hotkey| HotkeySerializer.new(HotKey) }.to_json
  end

  post '/api-ai' do
    push = JSON.parse(request.body.read)
    puts "I got some JSON: #{push.inspect}"
    content_type :json
  {  "speech": "the hotkeys are ...",
        "displayText": "the hotkeys are ...",
        #"data": {},
        # "contextOut": [],
        "source": "Hotkey" }.to_json
end
