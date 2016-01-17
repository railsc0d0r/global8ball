# coding: utf-8
Angenommen(/^eine Datei "(.*?)" im Testfixtures\-Verzeichnis\.$/) do |filename|
  File.file?(TestFiles.folder_path.join(filename))
end

Wenn(/^ich das Bild "(.*?)" als Hintergrundbild auswähle\.$/) do |filename|
  # We inject the encoded data for the image directly into the app-controller because of a bug in phantomjs.
  # Beware: this is not implementation-agnostic!!!
  data_url = DataUrl.from_image filename
  evaluate_script("Frontend.__container__.lookup('controller:section.upload-background').set('background',#{data_url.to_json});")
end
