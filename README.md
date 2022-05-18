# dungeon-adventure

Dungeon adventure is a role-playing game. In the game, the player will be able to move in different directions to get into different rooms of a dungeon. If the player stays in the dungeon enough, he/she will eventually meet his/her arch enemy.

### Prerequisites

To play this game, a terminal is required with **ruby** and **bundler** installed in the system.

### How to Install

Clone the repository in you local machine with the following command:

    `git clone git@github.com:saadrumon/dungeon-adventure.git`

Then go inside the project directory using terminal and install required packages as follow:

    `cd dungeon-adventure && bundle install`

Now, copy the `.env.sample` file into `.env` file. Insert appropriate values in the `.env` file.

    `cp .env.sample .env && nano .env`

### How it Works

To start playing the game, navigate to the project directory in your favorite terminal and run the following command:

    `ruby game.rb`

You will see some messages in the console that will ask you to select any of some actions e.g., left, right, forward, backward, etc. By choosing the options, you will be able to move in a two-dimensional space. You can type `exit` if you want to quit the game.

### Run Tests

This project includes test codes written using `rspec`. To run the tests you need to navigate to the project directory from terminal and execute the command below:

    `rspec spec`

# Useful Links

1. Ruby documentation (https://www.ruby-lang.org/en/documentation/)
2. GitHub page of `rspec-rails` gem (https://github.com/rspec/rspec-rails)
