require 'poseidon'

module KA_consumer

	def KA_consumer.get_hwm(consumer)
		#consumer.fetch
		consumer.highwater_mark

	end

	def KA_consumer.get_msgs(consumer)
		#:max_wait_ms => 100ms, :socket_timeout_ms = 10000ms
		#optimization:  set :min_bytes => 0 instead of default 1, not to wait 10 seconds with nothing to be updated scenario
		messages = consumer.fetch(:min_bytes => 0)
	end

end
