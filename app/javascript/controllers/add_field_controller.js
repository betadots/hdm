import { Controller } from "stimulus"

export default class extends Controller {
  static values = {name: String, value: String};

  hidden() {
    const hiddenField = document.createElement("input");
    hiddenField.type = "hidden";
    hiddenField.name = this.nameValue;
    hiddenField.value = this.valueValue;
    this.element.insertAdjacentElement('beforebegin', hiddenField);
  }
}
