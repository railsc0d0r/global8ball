# coding: utf-8
Angenommen(/^eine Datei "(.*?)" im Testfixtures\-Verzeichnis\.$/) do |filename|
  File.file?(TestFiles.folder_path.join(filename))
end
