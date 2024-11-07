import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
	static targets = [ "userMenu" ];

	toggleMenu(event) {
		event.stopPropagation();
		this.userMenuTarget.classList.toggle("hidden");
	}
}
