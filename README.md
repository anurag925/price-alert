# README

This README would normally document whatever steps are necessary to get the application up and running.

Things you may want to cover:

* Ruby version
    3.2.2 or above

* System dependencies
    any system having postgresql, redis, ruby and rails

* Configuration
    have hardcoded values at the moment

* Database 
    if not using docker then please install postgres for the respective os and update database.yml accordingly

* Redis 
    if not using docker then please install redis for the respective os and add redis.yml accordingly

* Starting application without docker
    1. Move into the application directory
    2. Do bundle install
    3. run bundle exec rails s
    4. run bundle exec sidekiq
    5. bundle exec rake binance_price_fetch:start

* Deployment instructions
    1. Install Docker
    2. Wait for it to install
    3. Wait some more till installation completes
    4. run docker-compose up --build
    5. wait for build to complete

* After Deployment
    6. import https://api.postman.com/collections/23743854-9ac1cc4d-c43b-4fba-a5ac-7b82899f8259?access_key=PMAT-01H12MJMM80P9YJAKMPZRJCJE6 this collection and play around
    7. with create user api create the user
    8. with login api pass the credentials and get the token
    9. for rest of the apis pass the token as Authorization Bearer token
    10. Run the alert api to create an alert and wait an watch


ps- Mailer is not working cuz was not able to get free smtp so quickly. config is done just need to add if got.