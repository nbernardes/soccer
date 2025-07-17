# Soccer

Small app that provides a GraphQL API and a small LiveView UI of faked soccer players and teams.

#### App deployed on Render

Due to the way free tier apps work on render, expect the app to take time to initial rendering (inactivity sleep) and potentially not working (DB is deleted after a month).

- LiveView UI via [soccer-21ee.onrender.com](https://soccer-21ee.onrender.com)
- GraphiQL interface via [soccer-21ee.onrender.com/api/graphiql](https://soccer-21ee.onrender.com/api/graphiql)

## To run the app locally

- Make sure you have all correct versions installed from `mise.toml`
- Make sure you have a postgres client setup and ready for database creation
- Run `mix setup` and it will do the full setup including populating your database

#### App URLs

- LiveView UI via [localhost:4000](http://localhost:4000)
- GraphiQL interface via [localhost:4000/api/graphiql](http://localhost:4000/api/graphiql)
