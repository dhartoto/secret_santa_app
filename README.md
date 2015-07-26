# Secret Santa App
#### by Dito Hartoto

## Versions
- Ruby 2.2.2
- Rails 4.2.0
- Sqlite3 1.3.10

## Instructions
1. `git clone https://github.com/dhartoto/secret_santa_app.git`
2. `bundle install`
3. `bundle exec rake db:migrate`
4. `rails c`
5. Go to `localhost:3000` in your browser

There is a sample file you can use to upload in `public/examples`
After uploading a file, click on `View Results`.
Or click on the `X` to delete.

## Description
Secret Santa is a western Christmas tradition in which members of a group or
community are randomly assigned a person to whom they anonymously give a gift.
You’d like to run a Secret Santa this year with your friends and family, but
decide that rather than simply pulling names from a hat, you want a fancier,
more technical, and automated approach.
You can use whatever language, frameworks, technologies that you feel best fits
the problem and/or whatever you’re most comfortable with.

## High level requirements
At a minimum, the app should take a list of participants, randomly choose a
secret santa for each participant, and display the results.
#### Additionally:
- We’d like to ensure that people can’t be assigned to their significant other.
So the app needs to have some knowledge about relationships between participants.
e.g. Marge Simpson is Homer Simpson’s partner.
- Also, when we hold our secret santa again next year we want to ensure that the
assignments are different from the previous year. In other words, the app should
remember the last known assignments.

## Restrictions when assigning the Secret Santas
- You cannot be your own Secret Santa.
- You cannot be assigned the same Secret Santa that you got in the previous year.
- You cannot be your partner’s Secret Santa.
- You cannot have duplicate Secret Santas.

## Input
Input is a CSV file with two headers: full_name and partner_full_name

full_name | partner_full_name
--------- | -----------------
Homer Simpson | Marge Simpson
Marge Simpson | Homer Simpson

## Output
Output will be displayed on the screen with the following details per person:
- full name
- secret santa
- previous year secret santa
