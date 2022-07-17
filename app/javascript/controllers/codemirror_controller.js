import { Controller } from "@hotwired/stimulus"
import CodeMirror from 'codemirror'
import 'codemirror/mode/gfm/gfm'
import 'codemirror/addon/hint/show-hint'

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
      this.dispatch('blur', {
        target: document
      })
    })

    editor.on('change', () => {
      this.dispatch('change', {
        target: document,
        detail: {
          content: editor.getValue()
        }
      })
    })

    editor.on('keydown', (_, event) => {
      if(event.key === '#') {
        const snippets = [
          { text: 'const', displayText: 'const declarations' },
          { text: 'let', displayText: 'let declarations' },
          { text: 'var', displayText: 'var declarations' },
        ]

        CodeMirror.showHint(editor, () => {
          const cursor = editor.getCursor()
          const token = editor.getTokenAt(cursor)
          const start = token.start
          const end = cursor.ch
          const line = cursor.line
          const currentWord = token.string

          const list = snippets.filter(function (item) {
            return item.text.indexOf(currentWord) >= 0
          })

          return {
            list: list.length ? list : snippets,
            from: CodeMirror.Pos(line, start),
            to: CodeMirror.Pos(line, end)
          }
        }, { completeSingle: false })
      }
    })
  }
}



