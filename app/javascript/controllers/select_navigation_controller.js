import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  navigate() {
    const selectedOption = this.element.options[this.element.selectedIndex];
    Turbo.visit(selectedOption.dataset.url);
  }
}
