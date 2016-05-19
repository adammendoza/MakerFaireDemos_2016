#require "dweetio.class.nut:1.0.1"

dio <- DweetIO();
agentID <- split(http.agenturl(), "/").pop();

device.on("readings", function(readings) {
    server.log(http.jsonencode(readings));
    dio.dweet(agentID, readings);
});