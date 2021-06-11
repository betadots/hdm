import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["button", "field"];
  static values = { url: String };

  connect() {
  }

  updateField(event) {
    event.preventDefault();
    this.fieldTarget.disabled = true
    fetch(this.urlValue)
      .then(response => response.text())
      .then(text => {
        this.fieldTarget.value = text;
        this.fieldTarget.disabled = false;
      });
    this.buttonTarget.classList.add("disabled");
  }

  reset() {
    this.buttonTarget.classList.remove("disabled");
  }
}
