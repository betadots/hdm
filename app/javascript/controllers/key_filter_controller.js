import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "keys"];

  connect() {
    this.filter();
  }

  filter() {
    const search = this.inputTarget.value;
    this.keysTargets.forEach( keyLink => {
      if (search == "" || keyLink.innerText.indexOf(search) >= 0) {
        keyLink.classList.remove("d-none");
        const url = new URL(keyLink.href);
        url.searchParams.set('search', search);
        keyLink.href = url.toString();
      } else {
        keyLink.classList.add("d-none");
      }
    });
  }

  submit(event) {
    event.stopPropagation();
    event.preventDefault();
  }
}
