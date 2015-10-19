var page = require('webpage').create();
var test_url = "http://www.slce002.com/", tp = 'test4', page_tag = 'home_page', host = "slce002";
var page_element = 'a.see-more-text';

if (phantom.injectJs("waitfor.js")) {

    entry_time = new Date().getTime();
    // Open webpage, callback() is called using page.onLoadFinished
    page.open(test_url, function (status) {
        // Check for page load success
        if (status !== "success") {
            console.log("Unable to access network");
        } else {
            // Wait for page element be visible
            waitForFunc(function() {
                // Check in the page if a specific element is now visible
                return page.evaluate(function(selector) {
                    return $(selector).is(':visible');
                }, page_element);
            }, function() {
               console.log("Test completed...");
               //page.render('screenshots.png');
            }, 15000, page_tag, tp, test_url, host);
        }
    });
} else {
    console.log("can not find wairfor js, exiting...");
    phantom.exit(1);
}
