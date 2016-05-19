#require "dweetio.class.nut:1.0.0"
#require "Rocky.class.nut:1.2.3"
#require "Twitter.class.nut:1.1.0"

const CONSUMER_KEY = "<Your-Twitter-Consumer-Key-here>";
const CONSUMER_SECRET =  "<Your-Twitter-Consumer-Secret-here>";
const ACCESS_TOKEN    =  "<Your-Twitter-Access-Token-here>";
const ACCESS_SECRET   = "Your-Twitter-Access-Secret-here";

twitter <- Twitter(CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_SECRET);
app <- Rocky();
dio <- DweetIO();

dispense_time <- 0.4;
agentID <- split(http.agenturl(), "/").pop();
twitter_search <- "snackbot";

// Send dispense message to device
function dispense(time) {
    // Send message to device to despense candy
    device.send("dispense", time);
}

// Track tweets and follower using DweetIO
function dweet(followers=0) {
    // load saved data
    persist <- server.load();

    // Create slots in table if they don't exsist
    if (!("tweets" in persist)) persist.tweets <- 0;
    if (!("followers_tweeted" in persist)) persist.followers_tweeted <- 0;

    // Increment tweets and followers
    persist.tweets++;
    persist.followers_tweeted += followers;

    // Store updated counts
    server.save(persist);
    dio.dweet(agentID, persist);
}

// Open a twitter listener
twitter.stream(twitter_search, function(tweetData) {
    // Get follower count & update DweetIO
    local followers_count = tweetData.user.followers_count;
    dweet(followers_count);

    // Dispense candy based on number of twitter followers
    if(followers_count == 0) followers_count = 1; // math lol
    local ratio = dispense_time/2;
    local seconds = 0.1+math.log(followers_count)*ratio;
    dispense(seconds);
});

// Dispense candy when request comes into "give_me_candy" endpoint
app.get("/give_me_candy", function(context) {
    dispense(dispense_time);
    context.send("OK");
})