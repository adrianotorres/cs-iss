import { Controller } from "@hotwired/stimulus";

export class PhoneForm extends Controller {
  static targets = ["phoneRow"];
  phoneRowTarget: HTMLElement;

  addPhone() {
    const newPhoneRow = document.createElement("div");
    newPhoneRow.innerHTML = this.phoneRowTarget.innerHTML;
    newPhoneRow.classList.add("phone-row", "row");
    newPhoneRow.querySelector(".remove-phone-btn").classList.remove("d-none")
    newPhoneRow.querySelector(".add-phone-btn").classList.add("d-none")
    this.phoneRowTarget.parentElement.appendChild(newPhoneRow);
  }

  removePhone(event: Event) {
    const phoneRow = (event.target as HTMLElement).closest(".phone-row");
    if (phoneRow) {
      phoneRow.remove();
    }
  }
}
