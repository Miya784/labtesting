#!/bin/bash
cd /home/ec2-user/nextjs-app
npm install
pm2 start npm --name "nextjs-app" -- start
