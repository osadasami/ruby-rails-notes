import { Controller } from "@hotwired/stimulus"
import CodeMirror from 'codemirror'

// Connects to data-controller="codemirror"
export default class extends Controller {
  connect() {
    CodeMirror.fromTextArea(this.element)
  }
}
