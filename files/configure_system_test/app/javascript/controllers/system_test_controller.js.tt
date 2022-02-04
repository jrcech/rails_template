import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['stimulusTest', 'turboTest'];

  connect() {
    this.stimulusTestTarget.textContent = 'Stimulus loaded';

    if (typeof Turbo === 'undefined') {
      this.turboTestTarget.textContent = 'Turbo not loaded';
    } else {
      this.turboTestTarget.textContent = 'Turbo loaded';
    }
  }
}
