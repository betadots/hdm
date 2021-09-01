import { Controller } from "stimulus"

export default class extends Controller {
  remove(event) {
    event.preventDefault();
    this.element.parentNode.removeChild(this.element);
  }
}
