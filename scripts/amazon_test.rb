#!/usr/bin/env ruby

require 'amazon/ecs'

Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = 'AKIAIQRJZXVAEGFZB6NQ'
  options[:AWS_secret_key_id] = '4UtEUMOX117jXz7KBsEY918VXOWsFPH+aBqxq31c'
  options[:associate_tag] = 'tomoyukisdiar-22'
end

response = Amazon::Ecs.item_lookup(params[:asin], response_group: 'Medium', country: 'jp')
