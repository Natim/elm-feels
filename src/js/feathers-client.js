const feathers = require('feathers-client')
const rest = require('feathers-rest/client')

const HOST = 'http://localhost:3030'
const app = feathers()
  .configure(rest(HOST).fetch(global.fetch))

const feelService = app.service('feels')

module.exports = function (elmApp) {
  // GET /feels
  elmApp.ports.getFeels.subscribe(() => {
    feelService.get().then((result) => {
      elmApp.ports.getFeelsDone.send(result.data)
    }, () => {
      elmApp.ports.getFeelsDone.send({})
    })
  })

  // GET /feels/:id
  elmApp.ports.getFeel.subscribe((id) => {
    feelService.get(id).then((result) => {
      elmApp.ports.getFeelDone.send(result)
    }, () => {
      elmApp.ports.getFeelDone.send({})
    })
  })
}
