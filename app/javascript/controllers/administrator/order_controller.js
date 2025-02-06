import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="administrator--order"
export default class extends Controller {
    static targets = [ "updateStatusDialog", "updateStatusForm" ];
    
    showUpdateStatusDialog() {
        this.updateStatusDialogTarget.showModal();
    }

    hideUpdateStatusDialog() {
        this.updateStatusDialogTarget.close();
    }

    clearAndHideForm() {
        this.updateStatusFormTarget.reset();
        this.updateStatusDialogTarget.close();
    }
}
