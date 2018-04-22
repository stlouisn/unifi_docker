[travis_logo]: https://travis-ci.org/stlouisn/unifi_docker.svg?branch=master
[travis_url]: https://travis-ci.org/stlouisn/unifi_docker
[docker_stars_logo]: https://img.shields.io/docker/stars/stlouisn/unifi.svg
[docker_pulls_logo]: https://img.shields.io/docker/pulls/stlouisn/unifi.svg
[docker_hub_url]: https://hub.docker.com/r/stlouisn/unifi
[microbadger_url]: https://microbadger.com/images/stlouisn/unifi
[feathub_data]: http://feathub.com/stlouisn/unifi_docker?format=svg
[feathub_url]: http://feathub.com/stlouisn/unifi_docker
[issues_url]: https://github.com/stlouisn/unifi_docker/issues
[slack_url]: https://stlouisn.slack.com/messages/CAB1ASU9H

## UniFi Controller Docker

[![Build Status][travis_logo]][travis_url]
[![Docker Stars][docker_stars_logo]][docker_hub_url]
[![Docker Pulls][docker_pulls_logo]][docker_hub_url]

Unifi Controller is a wireless network management software used to manage and control Ubiquiti Networks wireless devices using a web browser.

### Tags

[![Version](https://images.microbadger.com/badges/version/stlouisn/unifi:stable.svg)][microbadger_url]
[![Layers](https://images.microbadger.com/badges/image/stlouisn/unifi:stable.svg)][microbadger_url]

[![Version](https://images.microbadger.com/badges/version/stlouisn/unifi:testing.svg)][microbadger_url]
[![Layers](https://images.microbadger.com/badges/image/stlouisn/unifi:testing.svg)][microbadger_url]

[![Version](https://images.microbadger.com/badges/version/stlouisn/unifi:5.8.svg)][microbadger_url]
[![Layers](https://images.microbadger.com/badges/image/stlouisn/unifi:5.8.svg)][microbadger_url]

[![Version](https://images.microbadger.com/badges/version/stlouisn/unifi:5.7.svg)][microbadger_url]
[![Layers](https://images.microbadger.com/badges/image/stlouisn/unifi:5.7.svg)][microbadger_url]

[![Version](https://images.microbadger.com/badges/version/stlouisn/unifi:5.6.svg)][microbadger_url]
[![Layers](https://images.microbadger.com/badges/image/stlouisn/unifi:5.6.svg)][microbadger_url]

[![Version](https://images.microbadger.com/badges/version/stlouisn/unifi:5.5.svg)][microbadger_url]
[![Layers](https://images.microbadger.com/badges/image/stlouisn/unifi:5.5.svg)][microbadger_url]

### Usage

```
cd /docker/unifi
curl --silent --show-error --output docker-compose.yml https://raw.githubusercontent.com/stlouisn/unifi_docker/master/docker-compose.yml
docker-compose up --detach --build --remove-orphans
```

### Feature Requests

[![Feature Requests][feathub_data]][feathub_url]

### Support

[![Slack Channel](https://img.shields.io/badge/-message-no.svg?colorA=a7a7a7&colorB=3eb991&logo=slack&logoWidth=14)][slack_url]
[![GitHub Issues](https://img.shields.io/badge/-issues-no.svg?colorA=a7a7a7&colorB=e01563&logo=github&logoWidth=14)][issues_url]

### Links

###### *https://community.ubnt.com/unifi/*
###### *[https://help.ubnt.com/current-controller-versions](https://help.ubnt.com/hc/en-us/articles/115000441548-UniFi-Current-Controller-Versions)*
