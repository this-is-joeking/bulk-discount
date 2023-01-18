# Little Esty Shop

## Collaborators
- Samuel Cox - [sambcox](https://www.github.com/sambcox)
- Joe King - [this-is-joeking](https://www.github.com/this-is-joeking) - Completed entirety of the bulk discount portion of this repository
- Ryan Canton - [ryancanton](https://www.github.com/ryancanton)
- Mike Cummins - [Mike-Cummins](https://www.github.com/Mike-Cummins)

## Description

"Little Esty Shop" is a group project where we built a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. We utilized rails to build application, and focused our learning on advanced routing, rake tasks that read csv files loading them into our database, complex ActiveRecord queries, simple consumption of GitHub's API, and basic CRUD funtionality while maintaining MVC standards. Our Database offers many different relationships (many-to-many or one-to-many) as shown by our schema outlined below.

## Schema/Database
   
   ![alt text](https://i.ibb.co/LNKtnLD/Screen-Shot-2023-01-13-at-2-17-17-PM.png "Database/Schema Image")

## Heroku Deployment
   [Here is our deployed Heroku App!](https://intense-chamber-60518.herokuapp.com/)

## Setup

This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:{drop,create,migrate}`
    * `rake csv_load:all`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Opportunities to Refactor

* The main opportunity to refactor we identified is our rake task which loads CSV data into the database. Currently it adds rows to the database line by    line. We could refactor this to use the gems `activerecord-copy` and `activerecord-import`. This would add each table to the database in entirety        instead of row by row reducing the time to load data significantly. Additionally, the file that parses the csv could be abstracted to multiple files.
* Cleanup date formatting for upcoming holidays
