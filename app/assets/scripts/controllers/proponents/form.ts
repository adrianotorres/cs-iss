import { Controller } from "@hotwired/stimulus";
import { calculateINSSDiscount } from "services/inssCalculator";
import Inputmask from "inputmask"
import { currencyMask } from "services/mask";

export class ProponentFormController extends Controller {
  static targets = ["salary", "inss", "cpf", "zipCode"];
  salaryTarget: HTMLInputElement & { inputmask?: Inputmask };
  inssTarget: HTMLInputElement;

  async calculate(event: Event) {
    event.preventDefault();

    const rawValue = this.salaryTarget.inputmask.unmaskedvalue();

    const salary = parseFloat(rawValue);
    const { discount } = await calculateINSSDiscount(salary);

    this.inssTarget.value = discount
  }

  salaryTargetConnected(target: Element) {
    currencyMask().mask(target);
  }

  inssTargetConnected(target: Element) {
    currencyMask().mask(target);
  }

  cpfTargetConnected(target: Element) {
    Inputmask('999.999.999-99').mask(target);
  }

  zipCodeTargetConnected(target: Element) {
    Inputmask('99999-999').mask(target);
  }
}