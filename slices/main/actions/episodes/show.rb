# frozen_string_literal: true

require 'byebug'

module Main
  module Actions
    module Episodes
      class Show < Main::Action
        params do
          required(:id).value(:string)
          maybe(:view).value(:string)
        end

        def handle(request, response)
          halt 400 unless request.params.valid?
          response.render view, id: request.params[:id], view: request.params[:view]
        end
      end
    end
  end
end
