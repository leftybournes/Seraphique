import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = [ "header", "products"];

	connect() {
		let productsPosition = this.productsTarget.getBoundingClientRect();
		let header = this.headerTarget;

		window.addEventListener("scroll", function() {
			if (window.scrollY >= productsPosition.y) {
				header.classList.remove("hidden");
			} else {
				if (!header.classList.contains("hidden")) {
					header.classList.add("hidden");
				}
			}
		});
	}
}
