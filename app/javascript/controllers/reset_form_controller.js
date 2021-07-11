import { Controller } from 'stimulus'

export default class extends Controller {

    reset() {
        this.element.reset()
        this.element.querySelector('input[type="submit"]').disabled = false
    }
}