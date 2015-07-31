function waitForFunc(testFx, onReady, timeOutMillis, tag, ka_topic) {
    var maxtimeOutMillis = timeOutMillis ? timeOutMillis : 15000, //< Default Max Timout is 3s
        start = new Date().getTime(),
        condition = false,
        interval = setInterval(function() {
            if ( (new Date().getTime() - start < maxtimeOutMillis) && !condition ) {
                // If not time-out yet and condition not yet fulfilled
                condition = (typeof(testFx) === "string" ? eval(testFx) : testFx()); //< defensive code
            } else {
                if(!condition) {
                    // If condition still not fulfilled (timeout but condition is 'false')
                    console.log("Test timed out...");
                    phantom.exit(1);
                } else {
                    // Condition fulfilled (timeout and/or condition is 'true')
                    var load_timing = (new Date().getTime() - entry);

                    console.log(load_timing);
                    typeof(onReady) === "string" ? eval(onReady) : onReady(); //< Do what it's supposed to do once the condition is fulfilled
                    clearInterval(interval); //< Stop this interval

                    // Kafka producer to log the page load timing
                    var kf_request = require('webpage').create();
                    var postBody = 'client_id=' + tag + '&topic=' + ka_topic + '&msg=' + load_timing;

                    kf_request.open('http://localhost:8887/postkf', 'post', postBody, function(status) {
                      console.log('Sent to the Kafka Ruby bindings: ' + status);
                      phantom.exit();
                    });
                }
            }
        }, 250); //< repeat check every 250ms
};