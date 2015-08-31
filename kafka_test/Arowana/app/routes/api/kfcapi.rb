#require 'sinatra'
require 'util/producer'
require 'util/consumer'
require 'poseidon'

module Arowana
    module RestAPI
        class KFCAPI < BaseAPI
            
           #var postBody = "client_id=aaa&topic=test&msg=#{load_timing}";
			post '/rest/postkf' do
				@client_id = params[:client_id]
				@topic = params[:topic]
				@messages = params[:msg]

				#TO-DO: Configurable
				result = KA_producer.send_sync('10.131.64.224', 9092, @client_id, @topic, @messages)
				if result
					p 'message sent to kafka server successful' 
				else
					p 'please check your kafka server...'
				end
			end

			get '/rest/getmsgs' do
				@tp_name = params[:topic]
				@partition_id = (params[:partition]==nil) ? params[:partition].to_i : 0

				#fetch the offset from offsets table
				@offset_value = Arowana::DBModel::Offsets.getOffsetByTopic(@tp_name).offset_id

				#get the next offset from Kafka Server, :socket_timeout_ms = 10s
				#TO-DO: Configurable
				@consumer = Poseidon::PartitionConsumer.new('test_consumer', '10.131.64.224', 9092, @tp_name, @partition_id, @offset_value)
				#consume the messages, wait sockettimeout(10s by default) if no new messages to consume
				@messages = KA_consumer.get_msgs(@consumer)
				@next_offset = KA_consumer.get_hwm(@consumer)

				if @next_offset > @offset_value

					@batch_data = []

					@messages.each do |m|
						@batch_data << m.value.split(',')
					end

					Arowana::DBModel::UserTiming.batchInsertByTopic(@tp_name, @batch_data)

					# save it to the offsets table
					Arowana::DBModel::Offsets.updateOffsetByTopic(@tp_name, @next_offset)

					@consumer.close

					msg_added_count = @next_offset - @offset_value 
					return "#{msg_added_count} records updated successfully!\n"
				else
					@messages.clear
					@consumer.close
					return "nothing needs to be updated!\n"
				end	
			end
        end
    end
end