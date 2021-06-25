import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['pinTitle', 'pinAbout', 'pinImage']

  connect() {

  }

  update(event) {
    let attachment_input = event.detail.formSubmission.formElement.querySelector('[id="pin_image"]');
    let pinImage = this.pinImageTarget
    if (attachment_input.files && attachment_input.files[0]) {
      let reader = new FileReader();

      reader.onload = function(e) {
        pinImage.src = e.target.result;
      }

      reader.readAsDataURL(attachment_input.files[0]);
    }

    this.pinTitleTarget.textContent = event.detail.formSubmission.formElement.querySelector('[id="pin_title"]').value
    this.pinAboutTarget.textContent = event.detail.formSubmission.formElement.querySelector('[id="pin_about"]').value
  }
}