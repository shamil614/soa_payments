require 'rubygems'
require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)

puts "Postgres #{ENV['DATABASE_URL']}"
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/soa_payments')

class Payment
  include DataMapper::Resource

  property :id, Serial
  property :user_id, Integer
  property :amount, Integer
  property :status, String

  # business logic...
  def self.find_payments(user_id, state)
    all(user_id: user_id, status: state)
  end
end

DataMapper.finalize
