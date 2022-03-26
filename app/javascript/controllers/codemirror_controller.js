import { Controller } from "@hotwired/stimulus"
import CodeMirror from 'codemirror'

// Connects to data-controller="codemirror"
export default class extends Controller {
  connect() {
    const editor = CodeMirror.fromTextArea(this.element)

    editor.on('blur', () => {
      this.dispatch('blur', {target: document})
    })
  }
}
