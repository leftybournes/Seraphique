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
				parseFloat(row.querySelector(".row-quantity").value);

			totalValue = ((totalValue * 100) + (value * 100)) / 100;
			quantity += rowQuantity;

			checkbox.checked = event.target.checked;
		}

		if (event.target.checked) {
			this.countTarget.innerHTML = quantity > 1
				? `Order Total ( ${quantity} items ) :`
				: `Order Total ( ${quantity} item ) :`;

			this.valueTarget.innerHTML = `$${totalValue.toFixed(2)}`;
		} else {
			this.countTarget.innerHTML = "Order Total ( 0 items ) :";
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
			let rowQuantityString = row.querySelector(".row-quantity").value;
			let rowQuantity = isNaN(rowQuantityString) || rowQuantityString === ""
				? 1
				: parseFloat(rowQuantityString);

			if (checkbox.checked) {
				totalValue = ((totalValue * 100) + (value * 100)) / 100;
				quantity += rowQuantity;
				totalChecked++;
			}
		}

		this.countTarget.innerHTML = quantity > 1
			? `Order Total ( ${quantity} items ) :`
			: `Order Total ( ${quantity} item ) :`;

		this.valueTarget.innerHTML = `$${totalValue.toFixed(2)}`;
		this.toggleAllTarget.indeterminate = totalChecked > 0
			&& totalChecked < this.productRowTargets.length;
		this.toggleAllTarget.checked = totalChecked === this.productRowTargets.length;
	}

	inputQuantity(event) {
		let row = event.target.closest(".product-row");
		let price = parseFloat(row.querySelector(".row-price").innerText);
		let rowValue = row.querySelector(".row-value");
		let quantity = parseFloat(event.currentTarget.value);

		if (quantity <= 0 || isNaN(quantity)) {
			quantity = 1;
		}

		rowValue.innerHTML = (quantity * price).toFixed(2);

		this.calculate();
	}

	decrementRow(event) {
		let row = event.target.closest(".product-row");
		let rowQuantity = row.querySelector(".row-quantity");
		let price = parseFloat(row.querySelector(".row-price").innerText);
		let rowValue = row.querySelector(".row-value");
		let quantity = parseFloat(rowQuantity.value);

		if (isNaN(quantity)) {
			quantity = 1;
		}

		if (quantity > 1) {
			quantity--;
		}

		rowQuantity.value = quantity;
		rowValue.innerHTML = (quantity * price).toFixed(2);

		this.calculate();
	}

	incrementRow(event) {
		let row = event.target.closest(".product-row");
		let rowQuantity = row.querySelector(".row-quantity");
		let price = parseFloat(row.querySelector(".row-price").innerText);
		let rowValue = row.querySelector(".row-value");
		let quantity = parseFloat(rowQuantity.value);

		if (isNaN(quantity)) {
			quantity = 0;
		}

		quantity++;

		rowQuantity.value = quantity;
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
