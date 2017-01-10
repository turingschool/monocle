# [Monocle](https://turingmonocle-production.herokuapp.com)

[Monocle](https://turingmonocle-production.herokuapp.com) is company and job seeking tool for the Turing School community. It's purpose is to provide access to a large directory of technical companies that can be navigated in a simple and intuitive way. Once signed in, users will have the option to star companies and listings they are interested in to review at a later time. It can be accessed with a TuringSchool Census account, which you will be prompted to create from Monocle.

Monocle has 2 Heroku sites for you to use:
* [Staging](https://turingmonocle-staging.herokuapp.com)
* [Production](https://turingmonocle-production.herokuapp.com)

## Setting up the Development Environment

 1. Fork this Repo
 2. Run `bundle install`
 3. You will need API Keys for Census, Google Maps, and AWS.
 4. install Figaro to access the application.yml file and place your keys in with this syntax to ensure matching variables:

 ```
 S3_KEY: "enter_key"
 S3_SECRET: "enter_key"
 S3_REGION: "region_from_AWS"
 S3_DIRECTORY: "directory_from_AWS"

 census_id: enter_key
 census_secret: enter_key

 google_maps_key: "enter_key"
```

 5. run `rake db:create`
 6. run `rake db:migrate`
 7. run `rake db:seed`
