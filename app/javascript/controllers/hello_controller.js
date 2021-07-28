import { Controller } from "stimulus"

export default class extends Controller {

  static targets = [ "name", "output" ]

  connect() {
    // this.element.textContent = "Hello World!"
    // console.log(this.element)
    // console.log(this.world)
    // console.log(this.outputTargets)
    // this.outputTargets.forEach((elem) => {
    //   console.log(elem.textContent)
    // })
    // this.outputTarget.textContent = 'Welcome to Rambutan Code Academy!'
  }

  greet(event) {
    this.outputTarget.textContent =
      `Hello, ${this.nameTarget.value}!`

    // this.outputTargets.forEach((elem) => {
    //   elem.textContent =
    //   `Hello, ${this.nameTarget.value}!`
    // })

    this.data.set('world', 'haha')
    console.log(event.currentTarget.dataset.color)
    // console.log(this.world)
  }

  get world() {
    return this.data.get('world')
  }
}
