import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

// Connects to data-controller="note"
export default class extends Controller {
  static values = {
    updateUrl: String
  }

  connect() {
    // console.log(this.updateUrlValue)
    // console.log(this.contentTarget.value)
  }

  async save(e) {
    // const req = new FetchRequest('patch', this.updateUrlValue, {
    //   body: {content: e.detail.content},
    //   contentType: "application/json",
    // })

    // const res = await req.perform()

    // if(res.ok) {
    //   console.log('ok')
    // } else {
    //   console.log('err', res)
    // }
  }
}
