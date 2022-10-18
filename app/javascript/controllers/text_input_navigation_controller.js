import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

// Connects to data-controller="text-input-navigation"
export default class extends Controller {
  static targets = ["input"]
  static values = {placeholder: String, url: String}

  navigate() {
    const trimmedValue = this.inputTarget.value.trim()
    const url = this.urlValue.replace(this.placeholderValue, trimmedValue);
    Turbo.visit(url);
  }
}
