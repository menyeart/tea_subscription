# Tea Subscription REST API

    Tea Subscription is a student project for the Turing School of Software and Design Backend Software Engineering program. It demonstrates skills in creating API endpoints that return objects serialized to JSON:API spec, displaying CRUD fuctionality and showing a strong understanding of MVC and OOD principles in the context of a Ruby on Rails application.

# Built With

  ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) 
  ![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) 
  ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

### Prerequisites

  - Ruby Version 3.1.1
  - Rails Version 7.0.4.x

## Install
    
    bundle install

## Run the app

    rails s

## Run the tests

    bundle exec rspec

# REST API

## Create a new Customer Subscription

### Request

`POST /api/v1/customers/1/subscriptions`

Body:

  <pre>
    {
    "title": "A dance with Lady Grey",
    "price": 100.00,
    "frequency": "weekly",
    "tea_id": 2,
    "customer_id": 1
    }
  </pre>

### Response

<details>
  <pre>
    <code>
  {
      "data": {
          "id": "9",
          "type": "subscription",
          "attributes": {
              "title": "A dance with Lady Grey",
              "price": "100.0",
              "status": "active",
              "frequency": "weekly",
              "customer_id": 1,
              "tea_id": 2,
              "tea_name": "Kava"
          }
      }
  }
          </code>
  </pre>
</details>

## Get all of a customer's subscriptions

### Request

`GET api/v1/customers/1/subscriptions`

### Response
<details>
  <pre>
    <code>
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Wake up",
                "price": "20.0",
                "status": "active",
                "frequency": "weekly",
                "customer_id": 1,
                "tea_id": 1,
                "tea_name": "Earl Grey"
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Sleep well",
                "price": "10.0",
                "status": "active",
                "frequency": "monthly",
                "customer_id": 1,
                "tea_id": 10,
                "tea_name": "Mint"
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "\"A dance with lady grey\"",
                "price": "100.0",
                "status": "cancelled",
                "frequency": "monthly",
                "customer_id": 1,
                "tea_id": 1,
                "tea_name": "Earl Grey"
            }
        },
        {
            "id": "4",
            "type": "subscription",
            "attributes": {
                "title": "\"A dance with lady grey\"",
                "price": "100.0",
                "status": "active",
                "frequency": "monthly",
                "customer_id": 1,
                "tea_id": 1,
                "tea_name": "Earl Grey"
            }
        },
        {
            "id": "5",
            "type": "subscription",
            "attributes": {
                "title": "A dance with Lady Grey",
                "price": "100.0",
                "status": "active",
                "frequency": "weekly",
                "customer_id": 1,
                "tea_id": 2,
                "tea_name": "Kava"
            }
        },
        {
            "id": "6",
            "type": "subscription",
            "attributes": {
                "title": "A dance with Lady Grey",
                "price": "100.0",
                "status": "active",
                "frequency": "weekly",
                "customer_id": 1,
                "tea_id": 2,
                "tea_name": "Kava"
            }
        }
    ]
}
      </code>
  </pre>
</details>

## Update a subscription(change status)

### Request

`PATCH api/v1/customers/1/subscriptions/3`

<pre>
{
   "status": "cancelled"
}
</pre>
### Response

<details>
  <pre>
    <code>
  {
    "data": {
        "id": "3",
        "type": "subscription",
        "attributes": {
            "title": "\"A dance with lady grey\"",
            "price": "100.0",
            "status": "cancelled",
            "frequency": "monthly",
            "customer_id": 1,
            "tea_id": 1,
            "tea_name": "Earl Grey"
        }
    }
}
      </code>
  </pre>
</details>  

## Contributors

Matt Enyeart

Github: https://github.com/menyeart
LinkedIn https://www.linkedin.com/in/matt-enyeart/