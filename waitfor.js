function waitForFunc(testFx, onReady, timeOutMillis, tag, ka_topic, url, host) {
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
                    var load_timing = (new Date().getTime() - entry_time);

                    console.log(load_timing);
                    typeof(onReady) === "string" ? eval(onReady) : onReady(); //< Do what it's supposed to do once the condition is fulfilled
                    clearInterval(interval); //< Stop this interval

                    // Kafka producer to log the page load timing
                    if (phantom.injectJs("ka_client.js")) {
                        //kafka msg sent, need to sync with DB schema columns
                        msg = entry_time + ',' + url + ',' + tag + ',' + load_timing + ',' + host
                        msgPush(tag, ka_topic, msg);
                    } else {
                        console.log("check ka_client.js exsit if you need to post msg to kafka...");
                        phantom.exit();
                    }
                }
            }
        }, 250); //< repeat check every 250ms
};