# Fakebook

*Hi CurrencyCloud!*

This is my simplified version of Fakebook with a Coolpay module to allow our
precious users to exchange money instead of pokes!

Most of the interaction logic with the Coolpay APIs has been extracted to a gem
(not published to Rubygems ;). You can find the source code at: https://github.com/aomega08/coolpay-ruby

The gem is bundled into this Rails project, where ActiveRecord, ActiveJob &
ActionCable have all been stripped down.

In place of ActiveRecord I wrote some POROs mocking the Coolpay Business objects:
Recipients and Payments. They have an AR-like interface, like `.all` and `#save`.

## Installation

After cloning the project, you need to set up the Coolpay authentication keys in
the `config/application.yml` file, handled by `figaro`. You can find an example
in `config/application.example.yml`. In this way you do not commit your
super-sensitive API keys into git.

At this point you install all the dependencies, including my gem:

    bundle install

And you're ready to roll with a server:

    bundle exec rails server

## Running the suite

You can ensure that all tests pass with:

    bundle exec rspec

## Demo

I deployed a demo on Heroku. You can try it at: https://coolpay-francesco.herokuapp.com

If you, like me, decide to use Heroku to deploy this application, remember to
set the environment variables from `config/application.yml` with:

    figaro heroku:set -e production

## Enjoy
