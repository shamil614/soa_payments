require 'rubygems'
require 'data_mapper'
require './payment'
require 'bunny'
require 'json'
require 'byebug'

$bunny = Bunny.new
$bunny.start

class PaymentService
  attr_reader :channel, :queue, :exchange
  def initialize
    @channel = $bunny.create_channel
    @queue = @channel.queue('rpc_payment')
    @exchange = @channel.default_exchange
  end

  def init_rpc
    puts "Awaiting for RPC requests"
    queue.subscribe(block: true) do |delivery_info, properties, payload|
      message = JSON.parse payload
      result = Payment.send(message['method'], *message['params'])

      reply = { id: message['id'], result: result, jsonrpc: '2.0' }

      exchange.publish(JSON.generate(reply), { routing_key: properties.reply_to,
                                               correlation_id: properties.correlation_id })
    end
  end
end

begin
  payment_service = PaymentService.new
  payment_service.init_rpc
rescue Interrupt => _
  $bunny.close
end
