# frozen_string_literal: true

class MakePaymentOperation
  include Interactor::Organizer

  organize Payment::Validate, Payment::Authorize, Payment::Charge
end
