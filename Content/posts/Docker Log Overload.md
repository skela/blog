---
date: 2023-12-13 22:50
description: Avoiding your hard disks from filling up with junk due to excessive docker logging.
id: Docker Log Overload
tags: docker
---

By adding logging parameters to your docker-compose.yml file services, you can avoid your hard drive from filling up.

```
version: '3'

# Define a common logging configuration as an anchor
x-common-logging: &common-logging
  logging:
    driver: json-file
    options:
      max-size: "100m" # Set the maximum size of each log file to 10MB
      max-file: "10"   # Limit the number of log files to 5

services:

  hass:
    container_name: hass
    depends_on:
        - mosquitto
        - postgres
    image: homeassistant/home-assistant:2023.10
    restart: always
    network_mode: host
    privileged: true
    environment:
      - TZ=Europe/Oslo
    volumes:
      - ./hass/config:/config
    deploy:
      resources:
        limits:
          memory: 2000M
    <<: *common-logging

  nodered:
    container_name: nodered
    image: nodered/node-red:latest
    environment:
      TZ: Europe/Oslo
    ports:
      - "1880:1880"
    restart: always
    volumes:
      - ./nodered/data:/data
    deploy:
      resources:
        limits:
          memory: 500M
    <<: *common-logging
```
