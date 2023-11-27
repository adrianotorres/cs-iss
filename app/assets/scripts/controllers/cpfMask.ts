import { Controller } from "@hotwired/stimulus"
import Inputmask from 'inputmask'

export class CpfMask extends Controller {
  connect() {
    Inputmask('999.999.999-99').mask(this.element);
  }
}
