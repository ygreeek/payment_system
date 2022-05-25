# frozen_string_literal: true

class BaseInteractor
  include Interactor

  protected

  def fail!(msg)
    context.fail!(message: msg)
  end

  def success
    raise NotImplementedError
  end
end
