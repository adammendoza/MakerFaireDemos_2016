#require "ConnectionManager.class.nut:1.0.1"
#require "Si702x.class.nut:1.0.0"
#require "APDS9007.class.nut:2.2.1"
#require "LPS25H.class.nut:2.0.1"

// power and blinkup configuration
cm <- ConnectionManager({"blinkupBehavior": ConnectionManager.BLINK_ALWAYS, "stayConnected": true});

// log network and software info on boot up
server.log(imp.getsoftwareversion());
server.log(imp.getssid());


/*********** Env Sensor Tail Code ***********/

const readingInterval = 30; // Time in sec between readings
const readingWaitTime = 2; // Time to wait for readings to be returned
const readingEnableTimeout = 5; // Time to wait before first reading
const RLOAD = 47000.0;

i2c <- hardware.i2c89;
i2c.configure(CLOCK_SPEED_400_KHZ);

led <- hardware.pin2;
lxInputPin <- hardware.pin5;
lxEnablePin <- hardware.pin7;

led.configure(DIGITAL_OUT, 0);
lxInputPin.configure(ANALOG_IN);
lxEnablePin.configure(DIGITAL_OUT, 0);

th <- Si702x(i2c);
press <- LPS25H(i2c);
ambLX <- APDS9007(lxInputPin, RLOAD, lxEnablePin);
ambLX.enable(); // Takes 5s before a reading can be taken

function flashLed() {
    // Turn the LED on (write a HIGH value)
    led.write(1);

    // Block all execution for half a second
    imp.sleep(0.5);

    // Turn the LED off
    led.write(0);
}

function takeReadings() {
    readings <- {};

    th.read(function(res) {
        if("err" in res) {
            server.log(res.err);
        } else {
            readings.temperature <- res.temperature;
            readings.humidity <- res.humidity;
        }
    });

    ambLX.read(function(res) {
        if("err" in res) {
            server.log(res.err);
        } else {
            readings.brightness <- res.brightness;
        }
    });

    press.enable(true);
    press.read(function(res) {
        if("err" in res) {
            server.log(res.err);
        } else {
            readings.pressure <- res.pressure;
        }
    });

    // Send Readings
    imp.wakeup(readingWaitTime, function() {
        agent.send("readings", readings);
        flashLed();
        imp.wakeup(readingInterval, takeReadings);
    });
}

imp.wakeup(readingEnableTimeout, takeReadings);