## Load list(s) of forbidden passwords.
PASSWORD_BLACKLIST = Dir[Rails.root.join('config', 'wordlists', '*.txt')].reduce({}) do |wordlist, path|
  wordlist.merge! File.read(path).split(/\n+/).reduce({}) {|list, word| list[word.strip] = true ; list }
  next wordlist
end
