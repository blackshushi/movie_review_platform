# README
### Start from scratch
First of all, you will need to install some prerequisites listed below, it wouldn't be hard:
1. ruby  3.0.3
2. rails 7.0.1
---
### Installation and configuration
1. Clone the repo
2. Install dependencies
  ```
  bundle install
  ```
3. Setup database
  ```
  rake db:create
  rake db:migrate
  ```
4. Import Data(FYI, the csv is included in tmp directory which is ***movies.csv*** and ***reviews.csv***)
  ```
  rake "import_movies"
  rake "import_reviews
  ```

----
### Now you are ready to go!
1. To show the data listed in browser, run the following command under project directory
```
rails s
```

Open browser and go to http://localhost:3000 and you will see with a simple overview of movies listed in table form.

2. To get the datas from api which is json format. Use curl or postman to get the data. With the similar step as above, just to make sure the server is up, you are free to test it out.

Curl example:
- curl  -H "Content-Type: application/json" http://localhost:3000/api/movies

- curl  -H "Content-Type: application/json" http://localhost:3000/api/movies/1

3. Test cases
To run the test cases, simply run the following command under project directory
```
rspec spec
```
