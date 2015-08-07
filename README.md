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
> will adopt nightmare or phantasma lib instead of purely phantomjs to composite test scripts