# frozen_string_literal: true

module Endpoints
  module Helper
    def submit!(form:, with:)
      form = form.new(with)
      if form.submit
        yield(form)
      else
        status 400
        JSONAPI::Serializer.serialize_errors(form.errors).to_json
      end
    end

    def check!(interactor)
      if interactor.success?
        yield interactor
      else
        status 422
        JSONAPI::Serializer.serialize_errors(interactor.fail_message).to_json
      end
    end
  end
end
