import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "list"];

  search() {
    const searchValue = this.inputTarget.value;

    const searchParams = new URLSearchParams(window.location.search);
    searchParams.set("search", searchValue);
    const queryString = searchParams.toString();

    const newUrl = `${window.location.pathname}${
      queryString ? "?" + queryString : ""
    }`;
    history.pushState({ path: newUrl }, "", newUrl);

    fetch(
      `${window.location.pathname}?${new URLSearchParams({
        search: searchValue,
        format: "json",
      })}`
    )
      .then((response) => response.json())
      .then((artworks) => {
        this.listTarget.innerHTML = this.buildCards(artworks);
      });
  }

  buildCards(artworks) {
    return artworks
      .map(
        (artwork) => `
      <a href="${artwork.path}">
        <div class="card artwork-card">
          <img src="${artwork.photo_url}" alt="${artwork.title}" />
          <div class="card-artwork-infos">
            <div>
              <h2>${artwork.title}</h2>
              <h3>${artwork.artist_name}</h3>
              <p>${artwork.dimensions}</p>
              <div class="price-and-trash">
                <p>${artwork.price} €/jour</p>
                ${
                  artwork.can_delete
                    ? `<a href="${artwork.delete_path}" data-turbo="false" class="delete-link">
                       <i class="fa fa-trash" aria-hidden="true"></i>
                     </a>`
                    : ""
                }
              </div>
            </div>
          </div>
        </div>
      </a>
    `
      )
      .join("");
  }
}
