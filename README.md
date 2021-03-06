<h1 align="center">Welcome to Facebook replica 👋</h1>
<p>
  <a href="https://github.com/Nazeh/facebook-replica/blob/master/README.md" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="https://twitter.com/arnazeh" target="_blank">
    <img alt="Twitter: arnazeh" src="https://img.shields.io/twitter/follow/arnazeh.svg?style=social" />
  </a>
</p>

> An exercise building a clone of some of Facebook's features using Ruby on Rails.

### ✨ [Demo](https://fcborepl.herokuapp.com/)

<img alt='screenshot' src='docs/screenshot.webp'>

## 👌 Features

- **Users**
  - Sign-up / login / logout.
  - Show the profile page.
  - Create / update / delete posts.
  - Have many posts.

- **Posts**
  - Create / update / delete.
  - Show in chronological update order.
  - Belongs to a User.

- **Comments**
  - Create / update / delete.

- **Likes**
  - Like / unlike comments and/or posts.

- **Friendships**
  - Send / Accept a friend request.
  - Remove existing friends.
  - Feed with posts from yourself and friends only.

- **Notifications**
  - Receive  a notification for :
    - Comments on your posts.
    - Likes for your comments/posts.
    - Friendship requests and acceptance.

## 📝 Entity Relationship Diagram (ERD)

![alt text](docs/facebook_replica_ERD.jpeg)

## Requirements

- Ruby       '~>2.6.0'
- Bundler    '2.0.0'
- Rails      '~> 5.2.3'
- Postgresql '>= 0.18', '< 2.0'

## Install

Clone the repo and then install the needed gems:

```console
 bundle install --without production
```

Create and Migrate the database:

```console
 rails db:create
 rails db:migrate
```

## Usage


Populate the database [Optional] :

```console
 rails db:seed
```

Setup your Omniauth App [Optional] :

```console
 bundle exec figaro install
```

open the  config/application.yml and enter your APP_ID and APP_SECRET, for example:

```yaml
facebook_app_id: '5346435734534'
facebook_app_secret: '*********************'
```

Run the app in a local server:

```console
 rails server
```

## Author

👤 **Nazeh**

* Website: [Nazeh.me](https://www.nazeh.me/)
* Twitter: [@arnazeh](https://twitter.com/arnazeh)
* Github: [@nazeh](https://github.com/nazeh)
* LinkedIn: [@arnazeh](https://linkedin.com/in/arnazeh)

## Show your support

Give a ⭐️ if this project helped you!
