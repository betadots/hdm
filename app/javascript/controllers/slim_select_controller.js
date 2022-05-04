import { Controller } from "@hotwired/stimulus"
import SlimSelect from "slim-select"

export default class extends Controller {
  connect() {
    this.select = new SlimSelect({
      select: this.element,
    });
  }
  
  disconnect() {
    this.select.destroy();
  }
}
