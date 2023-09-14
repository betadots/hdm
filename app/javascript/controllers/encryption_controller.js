import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["decryptButton", "encryptButton", "field"];
  static values = { decryptUrl: String, encryptUrl: String };

  connect() {
    this.updateDecryptionStatus();
    this.updateEncryptionStatus();
  }

  decrypt(event) {
    event.preventDefault();
    this.makeRequest(this.decryptUrlValue, this.fieldTarget.value, (value) => value);
  }

  encrypt(event) {
    event.preventDefault();
    const start = this.fieldTarget.selectionStart;
    const end = this.fieldTarget.selectionEnd;
    const prefix = this.fieldTarget.value.slice(0, start);
    const postfix = this.fieldTarget.value.slice(end);
    const selection = this.fieldTarget.value.slice(start, end);
    this.makeRequest(this.encryptUrlValue, selection, (value) => `${prefix}${value}${postfix}`);
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

  updateEncryptionStatus() {
    if (!this.hasEncryptButtonTarget) return;
    if (this.fieldTarget.selectionStart < this.fieldTarget.selectionEnd) {
      this.encryptButtonTarget.classList.remove("disabled");
    } else {
      this.encryptButtonTarget.classList.add("disabled");
    }
  }

  csrfHeader () {
    const meta = document.querySelector('meta[name=csrf-token]');
    const token = meta.content;
    return {"X-CSRF-Token": token};
  }

  makeRequest(url, value, responseHandler) {
    const formData = new FormData();
    formData.append('value', value);
    this.fieldTarget.disabled = true
    fetch(url, {method: "POST", body: formData, headers: this.csrfHeader()})
      .then(response => response.text())
      .then(text => {
        this.fieldTarget.value = responseHandler(text);
        this.fieldTarget.disabled = false;
        this.updateDecryptionStatus();
        this.updateEncryptionStatus(); 
      });
  }
}
