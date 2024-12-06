import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    const urlParams = new URLSearchParams(window.location.search);
    const searchValue = urlParams.get("search");

    if (searchValue) {
      this.inputTarget.value = searchValue;
      this.inputTarget.focus();
      this.inputTarget.setSelectionRange(
        this.inputTarget.value.length,
        this.inputTarget.value.length
      );
    }
  }
}
