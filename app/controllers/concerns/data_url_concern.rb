#
# DataUrlConcern
#
# Contains methods to parse a DataUrl from frontend and return a file-handle for paperclip
#
#
module DataUrlConcern
  extend ActiveSupport::Concern

  private

  # Generates file from given params-array
  def convert_to_file(params_array)
    file_data = split_base64(params_array[:data])

    filename = "/tmp/#{params_array[:filename]}"

    File.open(filename, "w") do |tempfile|
      tempfile.binmode
      tempfile << Base64.decode64(file_data[:data])
      tempfile.rewind
    end

    File.open(filename)
  end

  def split_base64(uri_str)
    if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
      uri = Hash.new
      uri[:type] = $1
      uri[:encoder] = $2
      uri[:data] = $3
      uri[:extension] = $1.split('/')[1]
      return uri
    end
  end

end
