# frozen_string_literal: true
require 'byebug'
module Main
  module Actions
    module Episodes
      class Index < Main::Action
        def handle(request, response)
          paginate(request.params) { response.render view }
        end
      end
    end
  end
end
