import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["stimulusTest", "jqueryTest", "turbolinksTest"];

  connect() {
    this.stimulusTestTarget.textContent = "Stimulus loaded";

    if (typeof Turbolinks === "undefined") {
      this.turbolinksTestTarget.textContent = "Turbolinks not loaded";
    } else {
      this.turbolinksTestTarget.textContent = "Turbolinks loaded";
    }

    if (typeof jQuery === "undefined") {
      this.jqueryTestTarget.textContent = "jQuery not loaded";
    } else {
      this.jqueryTestTarget.textContent = "jQuery loaded";
    }

    $('[data-toggle="tooltip"]').tooltip();
  }
}
