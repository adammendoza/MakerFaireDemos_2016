#require "dweetio.class.nut:1.0.1"

dio <- DweetIO();
cowbellURL <- "https://agent.electricimp.com/YzzhSUaW8Isw"; // change this to your cowbell's agent URL
snackBotURL <- "https://agent.electricimp.com/wBudAOtahbne"; // change this to your snackbot's agent URL
agentID <- split(http.agenturl(), "/").pop();

// load saved data
persist <- server.load();
// create slot named "total" if it doesn't exsist
if (!("total" in persist)) persist.total <- 0;

device.on("buttonPress", function(data) {
    // log device data
    server.log(http.jsonencode(data));

    // send request to ring_cowbell route on cowbell imp
    http.get(cowbellURL + "/ring_cowbell").sendasync(function(resp) { server.log(resp.statuscode); });

    // send request to give_me_candy route on snackbot imp
    http.get(snackBotURL + "/give_me_candy").sendasync(function(resp) {server.log(resp.statuscode); });

    // increment button counter & store
    persist.total++;
    server.save(persist);

    // send dweet to update dashboard
    dio.dweet(agentID, { "total" : persist.total });
});