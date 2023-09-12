# HanamiMastery

This application is used to automate processes for smooth content production & publication of

- [Hanami Mastery episodes & articles](https://hanamimastery.com)
- [content_for :devs podcast episodes](https://www.contentfor.dev)

## Production

App is available under: [https://app.hanamimastery.com][https://app.hanamimastery.com]

## Learnings

The app production is showcased in [Hanami Mastery PRO](https://pro.hanamimastery.com) episodes. Make sure you subscribe to learn how to implement cool [Hanami 2](httpsh://hanamirb.org) features in your ruby apps.

## Features

### List episodes

Application allows to list episodes from the github repository and cache them in the database. Visiting the `episodes.index` action, cached episodes are listed from the database.

```
GET /episodes
```

### Fetching drafts from Github

To fetch new episodes from github Hanami Mastery repository, click the `fetch drafts` button. All new episodes will be added to the list, including unpublished ones.

This uses Github API to fetch all episodes, and filter only by those not yet imported.

For each episode it fills-in the details.


### Refreshing the details

For each episode you can fetch new details by clicking the button next to its row.

## Development

### Configuration

Check the `config/settings.rb` to see all the required settings.

```ruby
class Settings < Hanami::Settings
  setting :database_url
  setting :google_drive_id
  setting :google_application_credentials

  setting :github_access_token
end
```

**Starting the server**

```shell
hanami server
```

** Running tests**

```shell
rake # or rspec
```

## Deployment

App is deployed using: https://render.com/
