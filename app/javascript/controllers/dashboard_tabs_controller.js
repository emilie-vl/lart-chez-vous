import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard-tabs"
export default class extends Controller {
  static targets = ["myRentals", "myArtworks", "tabsUl", "myBookings"];

  connect() {
    const hash = window.location.hash;
    console.log("Stimulus connected. Current hash:", hash);

    if (hash === "#myArtworks") {
      this.showArtworks();
    } else if (hash === "#myBookings") {
      this.showBookings();
    } else {
      this.showRentals();
    }

    if (hash) {
      window.history.replaceState(null, null, hash);
    }
  }

  showArtworks(event = null) {
    if (event) event.preventDefault();
    this.removeActiveClass();
    if (event) event.target.classList.add("active");
    this.myArtworksTarget.classList.remove("d-none");
    this.myRentalsTarget.classList.add("d-none");
    this.myBookingsTarget.classList.add("d-none");

    if (window.location.hash !== "#myArtworks") {
      window.history.replaceState(null, null, "#myArtworks");
    }
  }

  showRentals(event = null) {
    if (event) event.preventDefault();
    this.removeActiveClass();
    if (event) event.target.classList.add("active");
    this.myArtworksTarget.classList.add("d-none");
    this.myRentalsTarget.classList.remove("d-none");
    this.myBookingsTarget.classList.add("d-none");

    window.history.replaceState(null, null, "#myRentals");
  }

  showBookings(event = null) {
    if (event) event.preventDefault();
    this.removeActiveClass();
    if (event) event.target.classList.add("active");
    this.myArtworksTarget.classList.add("d-none");
    this.myRentalsTarget.classList.add("d-none");
    this.myBookingsTarget.classList.remove("d-none");

    window.history.replaceState(null, null, "#myBookings");
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
