#Maker Faire Demos

Code for the demos seen in the Electric Imp booth at the 2016 Bay Area Maker Faire can be found in the folders in this repo.  Demos were all built using Imp001s and April breakout boards.


## What you need
* Electric Imp [dev kit(s)](http://www.amazon.com/WiFi-Environmental-Sensor-LED-kit/dp/B00ZQ4D1TM/ref=pd_bxgy_200_img_2?ie=UTF8&refRID=0GH4MF1KP5EFFZEEGYHV).

* A Twitter app.  Electric Imp has a Twitter integration found [here](https://github.com/electricimp/Twitter/tree/v1.2.1), this includes a link on how to create a Twitter app.

* DweetIO used to stream the Imp's data.  No account is needed to use DweetIO.  These examples use the imp's agent ID's to identify each datastream.  You will need the agent ID to setup the Freeboard dashboard.  More info Electric Imp's DweetIO integration can be found [here](https://github.com/electricimp/Dweetio/tree/v1.0.1).

* A [**Freeboard** account](http://freeboard.io/) used to create a dashboard using DweetIO data steams.  The account is free, and the tutorial walks you through creating a dashboard.

Electric Imp getting started guide, squirrel programming guide, and other helpful information can be found in the [dev center](https://electricimp.com/docs/).

## Cowbell Demo

Press a big red button to ring a cowbell, and use DweetIO/Freeboard to track and display the number of times the cowbell has rung.  For cowbell harware setup and to hook your cowbell up to twitter see this [hackaday post](http://hackaday.com/2015/04/05/internet-of-cowbell/).  For a button controlled cowbell a second imp connected to a button is needed.  The code included in this repo is for creating a button controlled cowbell.

## Environmental Sensor Tail Demo

Take temperature, humidity, pressure, and light readings and post to DweetIO.  Use Freeboard to create visualizations and monitor evironmental conditions.

## Snackbot

Tweet to get candy...add more followers on twitter to get more candy.  For step by step instructions on how to imp a candy maker see [this instructable](http://www.instructables.com/id/SnackBot-The-Internet-Connected-Candy-Machine/).

# License
Code here is licensed under the [MIT License](./LICENSE).