function msgPush(clientid, topic, data) {
	var kf_request = require('webpage').create();
	var postBody = 'client_id=' + clientid + '&topic=' + topic + '&msg=' + data;
	var end_point = 'http://localhost:9292/rest/postkf';

	kf_request.open(end_point, 'post', postBody, function(status) {
		console.log('Sent to the Kafka Ruby bindings: ' + status);
		phantom.exit();
	});
}