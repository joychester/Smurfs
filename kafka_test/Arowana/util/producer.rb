require 'poseidon'

module KA_producer

	def KA_producer.send_sync(client_id, topic_name, msg)

			producer = Poseidon::Producer.new(["#{KA_HOST}:#{KA_PORT}"], client_id,:type => :sync)

			messages = []
			#messages << Poseidon::MessageToSend.new(topic_name, client_id + ',' + msg)
			messages << Poseidon::MessageToSend.new(topic_name, msg)

			producer.send_messages(messages)
			producer.close
	end
	
end
