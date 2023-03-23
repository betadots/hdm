import { Controller } from "@hotwired/stimulus"
import SlimSelect from "slim-select"

export default class extends Controller {
  static targets = ["dropdown"]

  connect() {
    this.select = new SlimSelect({
      select: this.dropdownTarget,
    })
    this.hideOptions()
  }
  
  disconnect() {
    this.select.destroy()
  }

  toggleFilter(event) {
    if (event.target.checked) {
      this.hideOptions()
    } else {
      this.showAllOptions()
    }
  }

  hideOptions() {
    this.select.setData(this.select.getData().map((o) => {
      if (o["data"]["hidable"]) {
        o["display"] = false
      }
      return o
    }))
  }

  showAllOptions() {
    this.select.setData(this.select.getData().map((o) => {
      o["display"] = true
      return o
    }))
  }
}
