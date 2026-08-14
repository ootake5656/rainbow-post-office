import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static values = {
    url: String,
    delay: Number
  }

  connect() {
    this.timer = setTimeout(() => {
      Turbo.visit(this.urlValue, { action: "replace" })
    }, this.delayValue)
  }

  disconnect() {
    clearTimeout(this.timer)
  }
}