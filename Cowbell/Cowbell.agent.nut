#require "Rocky.class.nut:1.2.3"

// ring the cowbell when request comes into "ring cowbell" endpoint
app <- Rocky();
app.get("/ring_cowbell", function(context) {
    device.send("ring", null);
    context.send("OK");
})