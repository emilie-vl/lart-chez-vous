import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["beginDate", "endDate"];

  connect() {
    console.log("Hello");
  }

  validateDates() {
    const beginDate = new Date(this.beginDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);

    if (beginDate >= endDate) {
      alert("La date de fin doit être après la date de début.");
      this.endDateTarget.value = "";
    }
  }
}
