#!/usr/bin/ruby
require 'map'
require 'terrain'
require 'game_packet'
require 'battle'
require 'player'
Dir["players/*.rb"].each {|p| require p }

Battle.new(Map.new(80,30), Player.descendents.collect(&:new)).fight!
