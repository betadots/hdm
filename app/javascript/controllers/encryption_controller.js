import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["decryptButton", "encryptButton", "field"];
  static values = { decryptUrl: String, encryptUrl: String };

  connect() {
    this.updateDecryptionStatus();
  }

  decrypt(event) {
    event.preventDefault();
    const formData = new FormData();
    formData.append('value', this.fieldTarget.value);
    this.fieldTarget.disabled = true
    fetch(this.decryptUrlValue, {method: "POST", body: formData, headers: this.csrfHeader()})
      .then(response => response.text())
      .then(text => {
        this.fieldTarget.value = text;
        this.fieldTarget.disabled = false;
        this.updateDecryptionStatus();
      });
  }

  encrypt(event) {
    event.preventDefault();
    const formData = new FormData();
    formData.append('value', this.fieldTarget.value);
    this.fieldTarget.disabled = true
    fetch(this.encryptUrlValue, {method: "POST", body: formData, headers: this.csrfHeader()})
      .then(response => response.text())
      .then(text => {
        this.fieldTarget.value = text;
        this.fieldTarget.disabled = false;
        this.updateDecryptionStatus();
      });
  }

  reset() {
    setTimeout(() => this.updateDecryptionStatus(), 1);
  }

  updateDecryptionStatus() {
    const encryptionActive = this.fieldTarget.value.match(/ENC\[/);
    if (encryptionActive) {
      this.decryptButtonTarget.classList.remove("disabled");
    } else {
      this.decryptButtonTarget.classList.add("disabled");
    }
  }

  csrfHeader () {
    const meta = document.querySelector('meta[name=csrf-token]');
    const token = meta.content;
    return {"X-CSRF-Token": token};
  }
}
