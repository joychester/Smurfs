require 'concurrent'
require 'concurrent/actor'
require 'rufus-scheduler'

CURR_DIR = File.expand_path(__dir__)

@scheduler = Rufus::Scheduler.new

if ARGV.empty?
  p 'need to assign threads number and running loops, exit now'
  exit
else
  ACTOR_CNT = ARGV[0].to_i
  LOOP_CNT= ARGV[1].to_i
end

#looking for *.js as its test script and distribute to each actor message
@exec_js = (ARGV[2] == nil) ? Dir["./*_test_script/*.js"][0] : ARGV[2]

#Actor Class to handle the currency mode
class Phantom < Concurrent::Actor::Context
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

@test_started = Time.now.to_i

actor_arr = []

ACTOR_CNT.times do |i|
	actor_name = "phantom_actor_#{i}"
	actor_arr[i] = Phantom.spawn(actor_name)
end

actor_arr.each { |actor|
  p "#{actor.name} starting running"
  #async call to launch phantomjs test
  actor.tell(@exec_js)
}

#check testing results until timed out
@scheduler.every '3s' do

  @test_duration = Time.now.to_i - @test_started

  #test timeout default value set to 5 mins
  if @test_duration <= 30
    p 'grabbing some results'
  else
    p "===Test Timed Out after #{@test_duration} seconds, exiting==="
    @scheduler.shutdown
  end
end

@scheduler.join