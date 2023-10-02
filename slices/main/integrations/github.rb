# frozen_string_literal: true

module Main
  module Integrations
    # Maintains content of Github File system for the configured REPO and Reference (heads/master)
    #
    class Github
      include Deps['github.client']

      REPO = 'swilgosz/hanamimastery'
      REF = 'heads/master'

      # @return [Array[Sawyer::Resource]] instance of the returned entry
      #   Example:
      #     {
      #       :path=>"data/episodes/1-creating-hanami-application.md",
      #       :mode=>"100644",
      #       :type=>"blob",
      #       :sha=>"3d152f3a8af52e13d0d2e12eed15af99e1ee8e45",
      #       :size=>7074,
      #       :url=>
      #       "https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/3d152f3a8af52e13d0d2e12eed15af99e1ee8e45"
      #     }
      #
      def entries
        client.tree(REPO, base_tree_sha, recursive: true).tree.
          select { |t| t.path.include?('data/episodes/') }
      rescue Octokit::Error.
        error = Hanamimastery::Errors::GithublServiceError.new(
          'Github data fetching error'
        )
        raise error
      end

      # Returns the Github Entry object representing pointer to a given episode file.
      # @param [String] Published episode number
      # @return [Array[Sawyer::Resource]] instance of the returned entry
      #   Example:
      #     {
      #       :path=>"data/episodes/1-creating-hanami-application.md",
      #       :mode=>"100644",
      #       :type=>"blob",
      #       :sha=>"3d152f3a8af52e13d0d2e12eed15af99e1ee8e45",
      #       :size=>7074,
      #       :url=>
      #       "https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/3d152f3a8af52e13d0d2e12eed15af99e1ee8e45"
      #     }
      #
      def find(id)
        entry = entries.find { |e| e.path.split('/').last.match(/^#{id}-/) }
        return entry if entry

        raise Hanamimastery::Errors::RecordNotFound.new(
          'Could not find the requested file in Github repository',
          source_id: id
        )
      end

      # Fetches the file content based on the given file path.
      #   Designed to work with text files.
      #  @param [String] The path to the given file in the repository tree
      #  @return [String] A decoded content of the fethed file.
      #
      # def fetch(path)
      #   res = client.contents(
      #     REPO,
      #     path: path,
      #     query: { ref: REF }
      #   )
      #   Base64.decode64(res.content)
      # rescue Octokit::Error => e
      #   error = Hanamimastery::Errors::GithubServiceError.new(
      #     'Fetching content of the requested file failed',
      #     source_path: path
      #   )
      #   raise error
      # end
      #
      def fetch(path)
        res = client.contents(REPO, path: path, query: { ref: REF })
        Base64.decode64(res.content)
      rescue StandardError
        error = Hanamimastery::Errors::GithubServiceError.new(
          "Cannot fetch the file content from GitHub repository",
          severity: :no_action,
          source_path: path
        )
        raise error
      end

      private

      # Gets the sha of the tree the latest commit in REF points to.
      # @api_private
      #
      def base_tree_sha
        latest_commit_sha = client.ref(REPO, REF).object.sha
        base_tree_sha = client.commit(REPO, latest_commit_sha).commit.tree.sha
      end
    end
  end
end
