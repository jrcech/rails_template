import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  visit(event) {
    if (
      event.target.parentElement === event.currentTarget &&
      window.getSelection().type !== 'Range'
    ) {
      Turbo.visit(this.data.get('link'));
    }
  }
}
