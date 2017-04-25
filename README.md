# ReadMe

Dicer is a social network for players of Wizard of the Coast's Dungeons & Dragons tabletop role-playing game. The purpose of Dicer is to facilitate the formation of play groups between users who wish to play in the same manner, for instance face to face or online, with the latest ruleset or with a more casual set of house rules, etc. 

A user has up to two roles on Dicer, a player and a Dungeon Master(DM), each with its own relevant profile. As a DM, the user searches for players interested in a certain type of campaign, while as a player, the user searches for DMs interested in running a certain kind of campaign or players that user would be interested to play with. 

Ruby Version: 2.3.1

Rails Version: 5.0.2

# Database
Dicer is configured to use sqlite3 in testing and development and postgres in production. To initialize your database, simply run rails db:migrate. Seed with rails db:seed.

Warning: The seeding file included here automatically creates a user with admin privileges. Do not use this seed data on your production database. 

# Tests
Tests can be run simply using the rails test command. 

Tests are written in minitest.

