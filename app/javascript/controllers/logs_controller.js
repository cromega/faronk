import { Controller } from "stimulus"
import Handlebars from "handlebars"

export default class extends Controller {
  static targets = [ "channel", "logs" ]

  connect() {
    this.prepare()

    this.channelTarget.innerText = "#dehat"
    this.load()
  }

  load() {
    fetch(this.data.get("url")).
      then(response => response.json()).
      then(logs => logs.reverse().forEach(log => {
        var html = this.template({sent_at: log.sent_at, user: log.user, message: log.message})
        this.logsTarget.insertAdjacentHTML("beforeend", html)
      })
      )
  }

  prepare() {
    var template = document.getElementById("log_template").innerHTML
    this.template = Handlebars.compile(template)

    Handlebars.registerHelper("formatDate", (date) => {
      console.log(date)
      return new Date(Date.parse(date)).toTimeString().split(' ')[0]
    })
  }
}
