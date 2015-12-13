# coding: utf-8
Angenommen /^ich klicke "([^"]*)"$/ do |option|
  retval = (option == "Ok") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")
end

Angenommen(/^die App ist im Browser geladen\.$/) do
  steps %{
    Wenn ich die Startseite aufrufe.
    Dann sollte die App im Browser geladen werden.
  }
end

Wenn(/^ich klicke "(.*?)"\.$/) do |option|
  steps %{ Angenommen ich klicke "#{option}" }
end

Angenommen(/^ich wähle "(.*?)" aus\.$/) do |link_name|
  steps %{ Wenn ich den "#{link_name}"-Link klicke }
end

Angenommen(/^ich warte (\d+) Sekunden\.$/) do |seconds|
  sleep seconds.to_i
end

Wenn(/^ich die Startseite aufrufe\.$/) do
  visit "/"
end

Wenn(/^ich in einem Dialog sehe "(.*?)"$/) do |content|
  steps %{ Dann möchte ich "#{content}" sehen. }
end

Wenn(/^ich den Modal-Dialog "(.*?)" sehe\.$/) do |content|
  raise "No dialog found." unless page.has_css?(".modal-dialog", :visible => true)

  steps %{ Dann möchte ich "#{content}" sehen. }
end

Wenn(/^ich den Dialog "(.*?)" sehe\.$/) do |content|
  steps %{ Dann möchte ich "#{content}" sehen. }
end

Dann(/^sehe ich die Statusmeldung "(.*?)"$/) do |msg|
  steps %{ Dann möchte ich "#{msg}" sehen. }
end

Wenn /^ich "([^"]*)" klicke $/ do |option|
  steps %Q{ Angenommen ich klicke "#{option}"}
end

Wenn(/^ich mit "(.*?)" bestätige$/) do |option|
  steps %Q{ Angenommen ich klicke "#{option}" }
end

Wenn(/^ich "(.*?)" in das "(.*?)"\-Feld eingebe$/) do |value, field_name|
  fill_in(field_name, :with => value)
end

Wenn(/^ich folgendes eingebe:$/) do |table|
  table.raw.each do |(field_name, value)|
    fill_in(field_name, with: value)
  end
end

Wenn(/^ich "(.*?)" als "(.*?)" eingebe\.$/) do |value, field_name|
  steps %{ Wenn ich "#{value}" in das "#{field_name}"-Feld eingebe }
end

Wenn(/^ich den "(.*?)"\-Button klicke$/) do |button_name|
  # Wait for button to appear
  sleep 1

  begin
    if Capybara.current_driver == :poltergeist
      page.find(:link_or_button, button_name).trigger('click')
    else
      click_link_or_button(button_name)
    end
  rescue => e
    puts e.awesome_inspect
    puts e.message
    puts e.backtrace.join("\n")
    raise "Something went wrong while clicking button '#{button_name}'"
  end
end

Wenn(/^ich den "(.*?)"\-Button klicke\.$/) do |button_name|
  steps %{ Wenn ich den "#{button_name}"-Button klicke }
end

Wenn(/^ich den Button "(.*?)" drücke$/) do |button_name|
  steps %{ Wenn ich den "#{button_name}"-Button klicke }
end

Wenn(/^ich drücke den Button "(.*?)"$/) do |button_name|
  steps %{ Wenn ich den "#{button_name}"-Button klicke }
end

Wenn(/^ich den Button "(.*?)" im Dialog drücke$/) do |button_name|
  # Wait for dialog to appear
  sleep 1

  raise "No dialog found." unless page.has_css?(".modal-dialog", :visible => true)
  within '.modal-dialog' do
    if Capybara.current_driver == :poltergeist
      find(:link_or_button, button_name).trigger('click')
    else
      click_link_or_button(button_name)
    end
  end
end

Wenn(/^ich den "(.*?)"\-Link klicke$/) do |link_name|
  page.has_css?(link_name, visible: true)
  if Capybara.current_driver == :poltergeist
    find(:link, link_name).trigger('click')
  else
    click_link(link_name)
  end
end

Wenn(/^ich den "(.*?)"\-Link klicke\.$/) do |link_name|
  steps %{ Wenn ich den "#{link_name}"-Link klicke}
end

Wenn(/^ich "(.*?)" als "(.*?)" auswähle\.$/) do |option, select_field|
  select(option, :from => select_field)
end

Wenn(/^ich die Datei "(.*?)" als "(.*?)" auswähle\.$/) do |file_name, field_name|
  attach_file(field_name, @test_path + file_name)
end

Wenn(/^ich die Checkbox "(.*?)" aktiviere\.$/) do |locator|
  check(locator)
end

Wenn(/^ich die Checkbox "(.*?)" deaktiviere\.$/) do |locator|
  uncheck(locator)
end

Wenn(/^ich "(.*?)" auf der Startseite auswähle\.$/) do |link_name|
  raise "Not on root." unless current_page == path_for('Startseite')
  steps %{ Wenn ich den "#{link_name}"-Link klicke }
end

Dann(/^(?:möchte ich|ich möchte) "(.*?)" sehen\.?$/) do |content|
  unless page.has_content?(:all, content)
    sleep 1
    unless page.has_content?(:all, content)
      screenshot_and_open_image
      raise "Content '#{content}' not found."
    end
  end
end

Dann(/^möchte ich "(.*?)" nicht sehen$/) do |content|
  raise "Content '#{content}' found, but not expected to be shown." if page.has_content?(:all, content)
end

Angenommen(/^ich sehe den Dialog "(.*?)"$/) do | dialog_content |
  steps %{ Dann möchte ich "#{dialog_content}" sehen }
end

Dann(/^möchte ich einen Dialog sehen "(.*?)"$/) do |dialog_content|
  steps %{ Dann möchte ich "#{dialog_content}" sehen }
end

Dann(/^möchte ich "(.*?)" nicht sehen\.$/) do |content|
  steps %{ Dann möchte ich "#{content}" nicht sehen }
end

Dann(/^möchte ich einen Button "(.*?)" sehen\.$/) do |button_name|
  raise "Button '#{button_name}' not found, but expected to be shown." if page.first('a', text: button_name).nil?
end

Dann(/^debug(?:ger|)$/) do
  ## Use `page' method to inspect the current state.
  binding.pry
end

Dann(/^screenshot\.$/) do
  sleep 3
  screenshot_and_open_image
end

Dann(/^möchte ich das "([^"]+)"( nicht|) sehen\.$/) do |selector_name, nicht|
  selector = selector_for(selector_name)
  if nicht.size == 0
    unless page.has_css?(selector)
      raise "Selector named '#{selector_name}' not found! (#{selector})"
    end
  else
    if page.has_css?(selector)
      raise "Expected selector named '#{selector_name}' not to be present, but it is! (#{selector})"
    end
  end
end

Wenn(/^ich das "([^"]+)" abschicke$/) do |form_selector_name|
  form = page.find(selector_for(form_selector_name))
  submit_button = form.find('input[type=submit]')
  submit_button.click
end

Dann(/^sollte die App im Browser geladen werden\.$/) do
  body_class = page.first('body')[:class]
  raise "App not loaded"  unless body_class == "ember-application"
end
