import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selection", "additionalFields"]

  connect() {
    this.showAdditionalFields()
  }

  showAdditionalFields() {
    const selection = this.selectionTarget.value

    for (const fields of this.additionalFieldsTargets) {
      const visible = fields.dataset.type === selection
      fields.disabled = !visible
      fields.hidden = !visible
    }
  }
}
