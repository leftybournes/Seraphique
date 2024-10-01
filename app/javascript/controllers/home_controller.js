import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = [ "header", "whyUs"];

	connect() {
		let whyUsPosition = this.whyUsTarget.getBoundingClientRect();
		let header = this.headerTarget;
		let intersection = whyUsPosition.y - 200;

		window.addEventListener("scroll", function() {

			if (window.scrollY >= intersection) {
				header.classList.remove("hidden");

				setTimeout(
					() => header.classList.remove("-translate-y-32"),
					100
				);
			} else {
				if (!header.classList.contains("-translate-y-32")) {
					header.classList.add("-translate-y-32");
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
