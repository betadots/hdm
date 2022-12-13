import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["container", "template"];

  append(event) {
    event.preventDefault();
    const template = this.templateTarget.innerHTML;
    this.containerTarget.insertAdjacentHTML('beforeend', template);
  }
}
