const feathers = require('feathers-client')
const rest = require('feathers-rest/client')

const HOST = 'http://localhost:3030'
const app = feathers()
  .configure(rest(HOST).fetch(global.fetch))

// const feelService = app.service('feels')
