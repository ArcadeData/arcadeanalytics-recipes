# arcadeanalytics-recipes
# Arcade Analytics - Play With Data

A set of recipes to show how to use Arcade Analytics with different data stores

Docker images of Arcade and demo databases are available on [Docker hub](https://cloud.docker.com/u/arcadeanalytics/)

## Prerequisites

Install Docker on you computer: https://docs.docker.com/install/


## Run Arcade on your desktop using "single" (embedded) image

Arcade is provided as a all-embedded image, where hsql and embedded Elasicsearch are used instead of Postgresql and ES on separate containers.
This configuration is the most indicated to be used on a desktop computer because it needs less resources.
Open a shell/cmd and type:

    docker-compose -f recipes/arcade-standalone.yml up

The command above starts Arcade, you can top the container with a *ctrl+c* on the command line. To run Arcade in background, use the _-d_ switch:

    docker-compose -f recipes/arcade-standalone.yml up -d 
     
Point your browser to
    
    http://localhost:8080/
    
login as _user_ with password _user_

*NOTE*: This compose does not containers with test databases, they are commented and not started. 

### Create more users

To be able to create new users, stop Arcade with _ctrl+c_ on the command line or, if the _-d_ flag was used, type the command:

    docker-compose -f recipes/arcade-standalone.yml down 

Open the compose definition *recipes/arcade-standalone.yml* with an editor of your choice and fill the properties inside the compose:

          - SPRING_EMAIL_HOST=smtp.gmail.com 
          - SPRING_EMAIL_PORT=587
          - SPRING_EMAIL_USERNAME=
          - SPRING_EMAIL_PASSWORD=
          - JHIPSTER_MAIL_FROM=
          - JHIPSTER_MAIL_BASE-URL=

Then restart the container and login with admin/admin credentials. 
In the _admin_ menu you are now able to create new users.

## OrientDB 3.0.x: explore the demo database

To play with the OrientDB's demo database, open a new shell and start the container:

    docker-compose -f recipes/orientdb3.yml up

Now, to connect and use the database, go to Arcade, create a new data source with these parameters:

* type: OrientDB 3
* server: arcadeanalytics-orientdb3
* port: 2424
* database: demodb
* username: admin
* password: admin

Save and start the index process of the data source.
 

## OrientDB 3.0.x: explore the demo database with Gremlin

To play with the OrientDB's demo database, open a new shell and start the container:

    docker-compose -f recipes/orientdb3.yml up

Now, to connect and use the database, go to Arcade, create a new data source with these parameters:

* type: Gremlin/OrientDB
* server: arcadeanalytics-orientdb3
* port: 8182
* database: na
* username: na
* password: na

Save and start the index process of the data source.

## PostgreSQL: explore the dvd rental database

To play with the PostgreSQL's [dvd-rental database](http://www.postgresqltutorial.com/postgresql-sample-database/), open a new shell and start the container:

    docker-compose -f recipes/postgresql-dvd-rental.yml up

Now, to connect and use the database, go to Arcade, create a new data source with these parameters:

* type: RDBMS/PostgreSQL
* server: arcadeanalytics-postgresql-dvd-rental
* port: 5432
* database: dvdrental
* username: postgres
* password: postgres

## MySQL: explore the "sakila" database

To play with the MySQL's [sakila database](https://dev.mysql.com/doc/sakila/en/), open a new shell and start the container:

    docker-compose -f recipes/mysql-sakila.yml up

Now, to connect and use the database, go to Arcade, create a new data source with these parameters:

* type: RDBMS/MySQL
* server: arcadeanalytics-mysql-sakila
* port: 3306
* database: sakila
* username: test
* password: test





