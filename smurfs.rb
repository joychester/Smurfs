require 'rufus-scheduler'

require './cmdParser'
require './phantomActor'

CURR_DIR = File.expand_path(__dir__)

include CmdParser

if ARGV.empty?
  p 'empty option, type -h option for help, exit now...'
  exit
else
  @options = CmdParser.getoptions(ARGV)

  ACTOR_CNT = @options[:users].to_i #should be mandatory
  if @options[:loops] != nil
    LOOP_CNT = @options[:loops].to_i 
  elsif @options[:duration] !=nil
    LOOP_CNT = 99999 #set to max loop counts until test duration reached
  else
    p 'incorrect options, type -h option for help, exit now...'
    exit
  end
end

@scheduler = Rufus::Scheduler.new

#looking for *.js as its test script and distribute to each actor message
@exec_js = (@options[:file] == nil) ? Dir["./*_test_script/*.js"][0] : @options[:file]
#set timeout value for the test duration, default=5 mins
@timeout = (@options[:duration] == nil) ? 300 : @options[:duration].to_i


@test_started = Time.now.to_i

actor_arr = []

ACTOR_CNT.times do |i|
	actor_name = "phantom_actor_#{i}"
	actor_arr[i] = PhantomActor.spawn(actor_name)
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
  if @test_duration <= @timeout
    p 'grabbing some results'
  else
    p "===Test Timed Out after #{@test_duration} seconds, exiting==="
    @scheduler.shutdown
  end
end

@scheduler.join