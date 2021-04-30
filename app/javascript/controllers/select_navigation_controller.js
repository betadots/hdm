import { Controller } from "stimulus"
const Turbolinks = require("turbolinks")

export default class extends Controller {
  navigate() {
    const selectedOption = this.element.options[this.element.selectedIndex];
    Turbolinks.visit(selectedOption.dataset.url);
  }
}
