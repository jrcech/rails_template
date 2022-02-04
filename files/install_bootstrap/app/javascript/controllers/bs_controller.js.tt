import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['tooltip', 'popover'];

  connect() {
    this.tooltipTargets.map(
      (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl)
    );

    this.popoverTargets.map(
      (popoverTriggerEl) => new bootstrap.Popover(popoverTriggerEl)
    );
  }
}
