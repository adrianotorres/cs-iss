// Import and register all your controllers from the importmap under controllers/*

import { Application } from "@hotwired/stimulus"

import { PhoneForm } from "./phoneForm"
import { ProponentFormController } from "./proponents/form"
import { ProponentPresenterController } from "./proponents/presenter"
import { ProponentListController } from "./proponents/list"

const application = Application.start()

declare const window: Window &
  typeof globalThis & { Stimulus: typeof application}

application.register('phone-form', PhoneForm)
application.register('proponent-form', ProponentFormController)
application.register('proponent-presenter', ProponentPresenterController)
application.register('proponent-list', ProponentListController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
