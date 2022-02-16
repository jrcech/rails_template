import { Controller } from '@hotwired/stimulus';
import * as bootstrap from 'bootstrap';

export default class extends Controller {
  static targets = ['tooltip', 'popover'];

  tooltipTargetConnected(target) {
    return new bootstrap.Tooltip(target);
  }

  popoverTargetConnected(target) {
    return new bootstrap.Popover(target);
  }
}
