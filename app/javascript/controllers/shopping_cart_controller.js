import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="shopping-cart"
export default class extends Controller {
	static targets = [
		"toggleAll",
		"checkbox",
		"productRow",
		"rowQuantityDecrement",
		"rowQuantity",
		"rowQuantityIncrement",
		"count",
		"value"
	];

	toggleAll(event) {
		let totalValue = 0.00;
		let quantity = 0;

		for (let row of this.productRowTargets) {
			let checkbox = row.querySelector("input[type=\"checkbox\"]");
			let value = parseFloat(row.querySelector(".row-value").innerText);
			let rowQuantity =
				parseFloat(row.querySelector(".row-quantity").innerText);

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

	calculate() {
		let quantity = 0;
		let totalValue = 0.00;
		let totalChecked = 0;

		for (let row of this.productRowTargets) {
			let checkbox = row.querySelector("input[type=\"checkbox\"]");
			let value = parseFloat(row.querySelector(".row-value").innerText);
			let rowQuantity =
				parseFloat(row.querySelector(".row-quantity").innerText);

			if (checkbox.checked) {
				totalValue = ((totalValue * 100) + (value * 100)) / 100;
				quantity += rowQuantity;
				totalChecked++;
			}
		}

		this.countTarget.innerHTML = quantity > 1
			? `Total (${quantity} items)`
			: `Total (${quantity} item)`;

		this.valueTarget.innerHTML = `$${totalValue.toFixed(2)}`;
		this.toggleAllTarget.indeterminate = totalChecked > 0
			&& totalChecked < this.productRowTargets.length;
		this.toggleAllTarget.checked = totalChecked === this.productRowTargets.length;
	}

	decrementRow(event) {
		let row = event.target.closest(".product-row");
		let rowQuantity = row.querySelector(".row-quantity");
		let price = parseFloat(row.querySelector(".row-price").innerText);
		let rowValue = row.querySelector(".row-value");
		let quantity = parseFloat(rowQuantity.innerText);

		if (quantity > 1) {
			quantity--;
		}

		rowQuantity.innerHTML = quantity;
		rowValue.innerHTML = (quantity * price).toFixed(2);

		this.calculate();
	}

	incrementRow(event) {
		let row = event.target.closest(".product-row");
		let rowQuantity = row.querySelector(".row-quantity");
		let price = parseFloat(row.querySelector(".row-price").innerText);
		let rowValue = row.querySelector(".row-value");
		let quantity = parseFloat(rowQuantity.innerText);

		quantity++;

		rowQuantity.innerHTML = quantity;
		rowValue.innerHTML = (quantity * price).toFixed(2);

		this.calculate();
	}

	deselectAndCalculate(event) {
		let row = event.target.closest(".product-row");
		let checkbox = row.querySelector("input[type=\"checkbox\"]");

		checkbox.checked = false;

		this.calculate();
	}
}
