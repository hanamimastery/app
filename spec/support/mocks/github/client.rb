# frozen_string_literal: true

# frozen_string_literal: true

module Mocks
  module Github
    # Simulates the Octokit::Client behaviour to skip real API calls
    #
    class Client
      # @return [Array[Sawyer::Resource]] instance of the returned entry
      #   Example:
      #     {
      #       :path=>"fixtures/1-creating-hanami-application.md",
      #       :mode=>"100644",
      #       :type=>"blob",
      #       :sha=>"3d152f3a8af52e13d0d2e12eed15af99e1ee8e45",
      #       :size=>7074,
      #       :url=>
      #       "https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/3d152f3a8af52e13d0d2e12eed15af99e1ee8e45"
      #     }
      #
      def entries
        [
          {
            path: 'fixtures/1-published-episode.md',
            mode: '100644',
            type: 'blob',
            sha: '3d152f3a8af52e13d0d2e12eed15af99e1ee8e45',
            size: 7074,
            url:
            'https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/3d152f3a8af52e13d0d2e12eed15af99e1ee8e45'
          },
          {
            path: 'fixtures/2-draft-episode.md',
            mode: '100644',
            type: 'blob',
            sha: '3d152f3a8af52e13d0d2e12eed15af99e1ee8e45',
            size: 7074,
            url:
            'https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/3d152f3a8af52e13d0d2e12eed15af99e1ee8e45'
          },
          {
            path: 'fixtures/3-scheduled-episode.md',
            mode: '100644',
            type: 'blob',
            sha: '3d152f3a8af52e13d0d2e12eed15af99e1ee8e45',
            size: 7074,
            url:
            'https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/3d152f3a8af52e13d0d2e12eed15af99e1ee8e45'
          }
        ]
      end

      # Returns the Github Entry object representing pointer to a given episode file.
      # @param [String] Published episode number
      # @return [Array[Sawyer::Resource]] instance of the returned entry
      #   Example:
      #     {
      #       :path=>"fixtures/1-creating-hanami-application.md",
      #       :mode=>"100644",
      #       :type=>"blob",
      #       :sha=>"3d152f3a8af52e13d0d2e12eed15af99e1ee8e45",
      #       :size=>7074,
      #       :url=>
      #       "https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/3d152f3a8af52e13d0d2e12eed15af99e1ee8e45"
      #     }
      #
      def find(id)
        entry = entries.find { |e| e[:path].split('/').last.match(/^#{id}-/) }
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
      def fetch(path)
        File.read("#{__dir__}/#{path}")
      end

      def commit
        # file_name = File.join("some_dir", "new_file.txt")
        # blob_sha = github.create_blob(repo, Base64.encode64(my_content), "base64")
        # sha_new_tree = github.create_tree(repo,
        #                            [ { :path => file_name,
        #                                :mode => "100644",
        #                                :type => "blob",
        #                                :sha => blob_sha } ],
        #                            {:base_tree => sha_base_tree }).sha
        # commit_message = "Committed via Octokit!"
        # sha_new_commit = github.create_commit(repo, commit_message, sha_new_tree, sha_latest_commit).sha
      end
    end
  end
end
