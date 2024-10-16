# frozen_string_literal: true

require 'byebug'

container = Main::Slice.container
container['repos.episodes'].all.delete
interactor = container['interactors.fetch_draft_episodes']
interactor.call
