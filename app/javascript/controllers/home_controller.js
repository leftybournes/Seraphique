import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = [ "header", "products"];

	connect() {
		let productsPosition = this.productsTarget.getBoundingClientRect();
		let header = this.headerTarget;

		window.addEventListener("scroll", function() {
			if (window.scrollY >= productsPosition.y) {
				header.classList.remove("hidden");

				setTimeout(
					() => header.classList.remove("-translate-y-16"),
					100
				);
			} else {
				if (!header.classList.contains("-translate-y-16")) {
					header.classList.add("-translate-y-16");
				}

				if (!header.classList.contains("hidden")) {
					setTimeout(
						() => header.classList.add("hidden"),
						500
					);
				}
			}
		});
	}
}
