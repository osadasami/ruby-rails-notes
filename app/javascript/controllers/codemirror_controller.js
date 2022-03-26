import { Controller } from "@hotwired/stimulus"
import CodeMirror from 'codemirror'
import 'codemirror/mode/gfm/gfm'

// Connects to data-controller="codemirror"
export default class extends Controller {
  connect() {
    const editor = CodeMirror.fromTextArea(this.element, {
      tabSize: 2,
      indentWithTabs: false,
      theme: 'default',
      mode: {
        name: 'gfm',
        highlightFormatting: true,
      },
    })

    editor.on('blur', () => {
      this.dispatch('blur', {target: document})
    })

    editor.on('change', (editor) => {
      console.log(editor.getValue())
    })
  }
}



