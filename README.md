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
> ruby smurfs.rb 10 100 [./page1_test_script/page_perf_sample.js] 

Notice:
> First Param [10]: 10 Concurrent users  
> Second Param [100]: Execute 100 loops by each user
> Third Param [optional]: the test script you want to exec  
