import { LitElement, html } from "lit";

class CurrentTime extends LitElement {
  render() {
    return html`<p>${new Date().toLocaleTimeString()}</p>`;
  }
}

customElements.define("current-time", CurrentTime);
