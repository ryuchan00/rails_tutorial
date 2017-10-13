#!/bin/sh
heroku maintenance:on
git push heroku
heroku run rails db:migrate
heroku maintenance:off
