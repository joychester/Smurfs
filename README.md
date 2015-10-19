# Smurfs
Precondition: 
> * install ruby and Phantomjs, add them to PATH
> * gem install concurrent-ruby
> * gem install concurrent-ruby-edge
> * gem install concurrent-ruby-ext (optional, for perf improvement on MRI)
> * gem install rufus-scheduler (optional)
> * gem install poseidon (optional, for kafka client)
> * gem install sinatra (optional, create web server to forward kafka messages)  

How to: 
> ruby smurfs.rb -u 3 -l 10 -d 20 -g homepage -f ./page1_test_script/page_perf_sample.js  

Notice:
> First option [-u 3]: 3 Concurrent users  
> Second option [-l 10 optional]: Execute 10 loops by each user  
> Third option [-d 20 optional]: Test duration timed out value
> Fouth option [-g group optional]: Test Group Name 
> Fifth option [-f ./xxx/x.js]: Test script you want to exec  

To-Do:
> * [Deprecated] will adopt nightmare lib instead of raw phantomjs to composite test scripts  
> * Due to [the performance issue within Phantomjs](https://github.com/segmentio/nightmare/issues/200), nightmare is coming up with its [V2 Proposal](https://github.com/segmentio/nightmare/tree/v2)
> So we will stop using nightmareV1 in Smurf, and adpot nightmareV2 once it is released.(which means currently smurf project only support single page testing with phantomjs)

Update:  
Smurf V2 has been updated and tested on my side, check it out if you want to give it a [try](https://github.com/joychester/Smurfs_v2)
