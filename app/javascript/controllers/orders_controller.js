import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="orders"
export default class extends Controller {
    static targets = [ "modal" ];

    toggleModal() {
        this.modalTarget.classList.toggle("hidden");
    }

    toggleMenu(event) {
        let container = event.currentTarget.closest(".row-container");
        let menu = container.querySelector(".row-menu");

        menu.classList.toggle("hidden");
    }
}
