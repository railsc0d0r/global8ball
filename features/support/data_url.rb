module DataUrl

  # takes a filename, reads this file from TestUpload and returns a hash containing
  # filename, the content-type and a base64-encoded data-url
  def self.from_image filename=nil
    raise "no filename given." if filename.nil?
    raise "File not found" unless File.exists?(TestFiles.folder_path.join(filename))

    filename.match(%r{(\w*).(\w*)$})

    content_type = "image/#{$2}"

    file_blob = File.read(TestFiles.folder_path.join(filename))
    data_str = Base64.encode64(file_blob)
    # remove line-endings from encoded string
    data_str.gsub!("\n", '')

    { filename: filename, type: content_type, data: "data:#{content_type};base64,#{data_str}" }
  end
end
