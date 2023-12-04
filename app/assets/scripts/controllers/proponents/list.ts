import { Controller } from "@hotwired/stimulus";

export class ProponentListController extends Controller {
  confirm(event: Event) {
    const confirmation = confirm((event.target as HTMLButtonElement).dataset.confirm);
    if (!confirmation) {
      event.preventDefault();
    }
  }
}