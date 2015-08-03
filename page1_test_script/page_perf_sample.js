var page = require('webpage').create();
var test_url = "http://www.slce006.com/performer/136034/", tp = 'test', page_tag = 'artist_page';
var page_element = 'div.events_load_more';

if (phantom.injectJs("waitfor.js")) {

    entry = new Date().getTime();
    // Open webpage, onPageLoad, do...
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
            }, 15000, page_tag, tp);
        }
    });
} else {
    console.log("can not find wairfor js, exiting...");
    phantom.exit();
}