# Code challenge API


[<img src="https://github.com/fakefarm/war/blob/main/docs/yt.png">](https://www.youtube.com/watch?v=39SeWUPhCEY)

## Steps to test locally:

- Clone the repo
- `$ bundle install`
- `$ rails db:create db:migrate`
- get credentials from http://developer.marvel.com
- run tests `$ bundle exec rspec spec`
- rails server `$ bundle exec rails s`
- test in browser: visit:

http://localhost:3001/v1/combat.json?p1=hulk&p2=thor&seed_number=3

## Models & Services

Data models and business objects in the app

![](https://github.com/fakefarm/war/blob/main/docs/ms.jpg)

## Sequence

A flow of the request and response cycle.

![](https://github.com/fakefarm/war/blob/main/docs/sequence.jpg)

## Objective:

Text Based Marvel Combat Arena

Please create a text-based Marvel character combat arena using the public API available at developer.marvel.com. The combat arena will take 2 provided character names and then choose the winner based on the length of a specific word in their bio. Your code should demonstrate your ability to interface with an authenticated API, accept input from a user, and deal gracefully with errors and edge cases.

## Details:

Marvel’s developer portal has an API full of information about their greatest comics and characters which we’d like to utilize in this assessment so you will need to create a free Marvel Insider account in order to access it. After signup you should create an API key and familiarize yourself with the API documentation.

For this assessment, we will focus on the description field of the “characters” endpoint which can be accessed as such:

https://gateway.marvel.com/v1/public/characters?name=spider-man

Your code should satisfy the following criteria:
1. The user will provide 2 character names to do battle in the arena
2. The user will provide a SEED number between 1-9
3. Retrieve the bio for each character and parse the “description” field
4. Choose the WORD in each description at the position corresponding to the provided SEED
5. The winner of the battle is the character whose WORD has the most characters EXCEPT if either character has a MAGIC WORD “Gamma” or “Radioactive” they automatically Win
6. Present the winning character to the user
7. Handle any errors or edge cases and display the message in a user friendly manner
8. Provide clear instructions on how to retrieve and run your code
