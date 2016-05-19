#require "Button.class.nut:1.2.0"

// power and blinkup configuration
imp.enableblinkup(true);
imp.setpowersave(true);

// log network and software info on boot up
server.log(imp.getsoftwareversion());
server.log(imp.getssid());


/******* Button Code **************************/

function pressed() {
    server.log("button pressed");
    agent.send("buttonPress", {
        ts = time(),
        mac = imp.getmacaddress(),
        os = imp.getsoftwareversion(),
        rssi = imp.getrssi(),
        ssid = imp.getssid(),
        bssid = imp.getbssid(),
        voltage = hardware.voltage()
    });
}

button <- Button(hardware.pin1, DIGITAL_IN, Button.NORMALLY_LOW, pressed);