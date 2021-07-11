import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['boards']

  getOptions(event) {
    let form = event.detail.formSubmission.formElement
    let board_name = form.querySelector('[id="board_name"]').value
    let board_id = this.boardsTarget.lastChild.id.split('_')[1]
    let pin_board = document.getElementById('pin_board_id');
    let option = document.createElement("option");

    if (board_name != null && board_id != null) {
      option.text = board_name
      option.value = board_id
      pin_board.add(option)
    }
  }
}