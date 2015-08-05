require 'concurrent'
require 'concurrent/actor'

#Actor Class to handle the currency mode
class PhantomActor < Concurrent::Actor::Context
	def initialize()
    	@init_time = Time.now.to_f
  	end

  	 # override on_message to define actor's behaviour
  	def on_message(message)
  		if String === message 
  			LOOP_CNT.times do 
          # start the test, for example system("phantomjs page_perf_test.js")
          system("phantomjs #{message}")
        end
  		else 
  			raise TypeError, 'need to pass your test file name'
  		end
  	end
end