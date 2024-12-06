import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-redirection"
export default class extends Controller {
  static values = { user: Boolean };

  connect() {}

  redirect(event) {
    if (
      this.userValue &&
      window.location.pathname !== "/artworks" &&
      event.target.value.length > 0
    ) {
      const searchParams = new URLSearchParams();
      searchParams.append("search", event.target.value);
      window.location.href = `/artworks?${searchParams.toString()}`;
    }
  }
}
