import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="product-tabs"
export default class extends Controller {
	static targets = [ "directionsContent", "allergensContent" ];

	toggle(event) {
		if (event.target.id === "label-directions") {
			this.directionsContentTarget.classList.remove("hidden");
			this.allergensContentTarget.classList.add("hidden");
		} else if (event.target.id === "label-allergens") {
			this.allergensContentTarget.classList.remove("hidden");
			this.directionsContentTarget.classList.add("hidden");
		}
	}
}
