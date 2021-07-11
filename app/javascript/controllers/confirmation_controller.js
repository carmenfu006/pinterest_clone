import { Controller } from 'stimulus'

export default class extends Controller {
  static values = { message: String };

  confirm(event) {
    if (!(window.confirm(this.messageValue))) {
      event.preventDefault();

      // As if you have more than one event handler from being executed, you can add this method here
      // event.stopImmediatePropagation();
    };
  };
}