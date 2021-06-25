import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['pinTitle', 'pinAbout', 'pinImage']

  connect() {

  }

  // create(event) {
  //   console.log(event.detail.formSubmission)
  //   console.log(this.inputElementValue(event, 'pin_title'))
  //   if (event.detail.formSubmission.result.success) {
  //     const element = document.createElement('section');
  //     const list = this.pinListsTarget

  //     element.innerHTML = `<section class="col-6">
  //                           <turbo-frame id="pin_78">
  //                             <a href="/pins/78">
  //                                 <img style="width: 200px;" data-pin-update-target="pinImage" src="http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBiUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1d2cd451bcf54cfbf5bdd2ac8bfe4274067cf955/bunny.gif">
  //                               <p>cute</p>
  //                             </a>
  //                           </turbo-frame>
  //                         </section>`
  //     list.appendChild(element);
  //   }
  // }

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

    this.pinTitleTarget.textContent = this.inputElementValue(event, 'pin_title')
    this.pinAboutTarget.textContent = this.inputElementValue(event, 'pin_about')
  }


  inputElementValue(event, id) {
    return event.detail.formSubmission.formElement.querySelector(`[id=${id}]`).value
  }
}