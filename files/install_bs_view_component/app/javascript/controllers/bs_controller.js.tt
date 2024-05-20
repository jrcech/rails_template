import { Controller } from '@hotwired/stimulus';
import * as bootstrap from 'bootstrap';

export default class extends Controller {
  static targets = ['tooltip', 'popover', 'toast'];

  tooltipTargetConnected(target) {
    return new bootstrap.Tooltip(target);
  }

  popoverTargetConnected(target) {
    return new bootstrap.Popover(target);
  }

  toastTargetConnected(target) {
    const toaster = new bootstrap.Toast(target);

    toaster.show();
  }
}
