# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
* 
when install
run cmd "bundle install"
run cmd "rails db:migrate"
install redis
create file mylib.pth in /usr/local/lib/python2.7/dist-packages with content:
"{SDU-Learning-resource-aggregation-platform path}/app/jobs/python_lib"

when run
need to run cmd "sudo service redis-server start"
need to run cmd "sidekiq"
run cmd "rails s"
