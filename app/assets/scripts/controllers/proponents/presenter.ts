import { Controller } from "@hotwired/stimulus";
import { currencyMask } from "services/mask";

export class ProponentPresenterController extends Controller {
  static targets = ["salary", "salaryLiquid", "inss"];

  salaryTargetConnected(target: Element) {
    currencyMask().mask(target);
  }

  salaryLiquidTargetConnected(target: Element) {
    currencyMask().mask(target);
  }

  inssTargetConnected(target: Element) {
    currencyMask().mask(target);
  }
}