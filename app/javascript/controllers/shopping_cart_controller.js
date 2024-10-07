import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="shopping-cart"
export default class extends Controller {
	static targets = [ "checkbox", "productRow", "count", "value" ];

	toggleAll(event) {
		let totalValue = 0.00;
		let quantity = 0;

		for (let row of this.productRowTargets) {
			let checkbox = row.querySelector('input[type="checkbox"]');
			let value = parseFloat(row.querySelector('.row-value').innerText);
			let rowQuantity =
				parseFloat(row.querySelector('.row-quantity').innerText);

			totalValue = ((totalValue * 100) + (value * 100)) / 100;
			quantity += rowQuantity;

			checkbox.checked = event.target.checked;
		}

		if (event.target.checked) {
			this.countTarget.innerHTML = quantity > 1
				? `Total (${quantity} items)`
				: `Total (${quantity} item)`;

			this.valueTarget.innerHTML = `$${totalValue.toFixed(2)}`;
		} else {
			this.countTarget.innerHTML = "Total (0 items)";
			this.valueTarget.innerHTML = "$0.00";
		}
	}
}
