import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  connect() {
    const selectedOption = this.element.options[this.element.selectedIndex]
    this.initialUrl = selectedOption.dataset.url
  }

  navigate() {
    const selectedOption = this.element.options[this.element.selectedIndex]
    const newUrl = selectedOption.dataset.url
    if (newUrl != this.initialUrl) Turbo.visit(newUrl)
  }
}
