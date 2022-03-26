import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="note"
export default class extends Controller {
  static targets = ['submit']

  connect() {
  }

  save() {
    this.submitTarget.click()
  }
}
