# frozen_string_literal: true

module Main
  module Integrations
    # Maintains content of Google Drive Storage
    #
    class Drive
      include Deps['google.drive']

      DRIVE_ID = App['settings'].google_drive_id

      # Fetches the thumbnail image from configured drive
      #   based on provided episode ID.
      # @param [Integer] the ID of the episode
      # @return [Google::Apis::DriveV3::File]
      #
      def thumbnail(episode_id)
        str_id = format('%03d', episode_id)
        filename = "HME#{str_id}-cover"

        drive.list_files(
          drive_id: DRIVE_ID,
          include_items_from_all_drives: true,
          corpora: 'drive',
          supports_all_drives: true,
          q: "(mimeType='image/jpg' or mimeType='image/jpeg' or mimeType='image/png') and name contains '#{filename}'"
        ).files.first
      end

      # Downloads the the given file from configured drive
      #   and stores it under the 'tmp' path.
      # @param [Google::Apis::DriveV3::File]
      #
      def download(drive_file)
        dest = App.root.join("tmp/#{drive_file.name}").to_s
        drive.get_file(drive_file.id, download_dest: dest)
      end
    end
  end
end
