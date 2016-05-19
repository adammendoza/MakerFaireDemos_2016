// power and blinkup configuration
imp.enableblinkup(true);
imp.setpowersave(true);

// log network and software info on boot up
server.log(imp.getsoftwareversion());
server.log(imp.getssid());


/******* Snackbot Code **************************/

// Configure Pin
motor  <- hardware.pin9;
motor.configure(DIGITAL_OUT);
motor.write(0);

// Open listener
agent.on("dispense", function(seconds) {
    server.log("Imp Dispensing! Hello, Maker Faire! " + seconds);
    motor.write(1);
    imp.wakeup(seconds, function(){ motor.write(0);});
});