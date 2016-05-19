#require "ConnectionManager.class.nut:1.0.1"

// power and blinkup configuration
cm <- ConnectionManager({"blinkupBehavior": ConnectionManager.BLINK_ALWAYS, "stayConnected": true});

// log network and software info on boot up
server.log(imp.getsoftwareversion());
server.log(imp.getssid());


/******* Cowbell Code **************************/

counter <- hardware.pin5;
cowbell <- hardware.pin7;

counter.configure(DIGITAL_OUT, 0);
cowbell.configure(DIGITAL_OUT, 0);

agent.on("ring", function(context) {

    counter.write(1);

    cowbell.write(1);
    imp.sleep(0.01);
    cowbell.write(0);

    imp.sleep(0.04);
    counter.write(0);  // Counter takes a bit longer than the cowbell

});