# Public Asset Checker

Checks either the size or version of public - third-party hosted - asset files (e.g. JavaScript, CSS etc). We use these assets on GOV.UK pages, so we want to know if the file size or version have changed. To do this we evaluate each file against a known baseline size or version. This then notifies the #user-experience-measurement-govuk Slack channel of the result or action taken.

## Size checking

This compares the current file size (in bytes) with the latest known size. It uses a tolerance level to automatically update the latest known size if appropriate to minimise the amount of developer interaction and updates to the app.

Currently, the files checked are:

* https://www.googletagmanager.com/gtm.js
* https://www.googletagmanager.com/gtag/js

There are 3 possible outcomes when checking for size:

* __Update__ - the app will automatically update the latest known size of the file to the current size, if the difference between the latest known size and current size is within the tolerance level given.

* __Warning__ - given when the difference between the current size and the latest known size is outside of the tolerance level given.

* __Same__ - given when the current size and the latest known size are exactly the same.

## Version checking

Currently, the files checked are:

* https://cdn.speedcurve.com/js/lux.js

There are 2 possible outcomes when checking for version:

* __Warning__ - given when the current version and the latest known version are not the same.

* __Same__ - given when the current version and the latest known version are the same.

## Screenshots

The app is [hosted on Heroku](https://govuk-public-asset-checker.herokuapp.com/).

### [Status page](https://govuk-public-asset-checker.herokuapp.com)

![image](/docs/status-page.png)

### [Historical chart for file](https://govuk-public-asset-checker.herokuapp.com/public_assets/2)

![image](/docs/url-chart-page.png)

This page is also where you can update the last known size or version value for the asset.

### [Example Slack notifications](https://gds.slack.com/archives/C03BF2YV63E)

![image](/docs/slack-notifications.png)

## Technical documentation

The app is a standard Rails application.

### Before running the app

Prior to running the first time in development, and after migrating the database, you might find it useful to create some test data.

```shell
bundle exec rails db:seed
```

### Running the test suite

```shell
bundle exec rake
```

## Licence

[MIT Licence](LICENCE)
