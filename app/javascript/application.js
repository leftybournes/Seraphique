// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

document.addEventListener("click", function(event) {
	let userMenu = document.querySelector("div[data-header-target=userMenu]");

	if (userMenu === null || userMenu === undefined) return;

	if (userMenu.classList.contains("hidden")) return;

	userMenu.classList.add("hidden");
});
