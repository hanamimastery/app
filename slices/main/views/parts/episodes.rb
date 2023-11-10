# frozen_string_literal: true

module Main
  module Views
    module Parts
      class Episodes < Part
        include Hanamimastery::Utils::Pagination::Reader

        def link_to_previous_page
          page_number = pagination.number - 1
          prev_path = _context.routes.path(:episodes, 'page[number]': page_number, 'page[size]': pagination.size)
          helpers.link_to('Previous page', prev_path, class: "pagination-previous #{'is-disabled' unless page_number > 0}")
        end

        def link_to_next_page
          page_number = pagination.number + 1
          next_path = _context.routes.path(:episodes, 'page[number]': page_number, 'page[size]': pagination.size)
          helpers.link_to('Next page', next_path, class: "pagination-next")
        end
      end
    end
  end
end
