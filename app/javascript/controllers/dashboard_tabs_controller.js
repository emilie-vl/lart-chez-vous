import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard-tabs"
export default class extends Controller {
  static targets = ["myRentals", "myArtworks", "tabsUl", "myBookings"];

  connect() {}

  showArtworks(event) {
    event.preventDefault();
    this.removeActiveClass();
    event.target.classList.add("active");
    this.myArtworksTarget.classList.remove("d-none");
    this.myRentalsTarget.classList.add("d-none");
    this.myBookingsTarget.classList.add("d-none");
  }

  showRentals(event) {
    event.preventDefault();
    this.removeActiveClass();
    event.target.classList.add("active");
    this.myArtworksTarget.classList.add("d-none");
    this.myRentalsTarget.classList.remove("d-none");
    this.myBookingsTarget.classList.add("d-none");
  }

  showBookings(event) {
    event.preventDefault();
    this.removeActiveClass();
    event.target.classList.add("active");
    this.myArtworksTarget.classList.add("d-none");
    this.myRentalsTarget.classList.add("d-none");
    this.myBookingsTarget.classList.remove("d-none");
  }

  removeActiveClass() {
    const liElements = this.tabsUlTarget.children;
    for (const li of liElements) {
      const aElements = li.children;
      for (const a of aElements) {
        a.classList.remove("active");
      }
    }
  }
}
