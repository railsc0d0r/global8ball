#
# Model to provide a source for random names and strings
#
# * On new it takes a list of seeds
# * :name provides a string composed of a random 1st- and lastname
# * :user_name generates a username from one of 5 variants
# * :first_name provides a random firstname
# * :last_name provides a random lastname
# * :uuid provides a random uuid
# * :password provides a random devise-friendly token of 8 chars
# * :prepaid_token provides a random devise-friendly token of 24 chars
#
class StringRandom
  attr :seeds

  def initialize
    @seeds = { :first_name => %w(
                                  Jan
                                  Tobias
                                  Christian
                                  Alexander
                                  Daniel
                                  Patrick
                                  Dennis
                                  Sebastian
                                  Marcel
                                  Philipp
                                  Florian
                                  Kevin
                                  David
                                  Fabian
                                  Matthias
                                  Felix
                                  Benjamin
                                  Sven
                                  Jonas
                                  Lukas
                                  Lucas
                                  Tim
                                  Timo
                                  Julian
                                  Maximilian
                                  Simon
                                  Christoph
                                  Christopher
                                  Marco
                                  Marko
                                  Martin
                                  Michael
                                  Stefan
                                  Stephan
                                  Thomas
                                  Marc
                                  Mark
                                  Markus
                                  Marcus
                                  Nils
                                  Niels
                                  Julia
                                  Sarah
                                  Sara
                                  Jennifer
                                  Katharina
                                  Lisa
                                  Christina
                                  Jessika
                                  Jessica
                                  Anna
                                  Laura
                                  Melanie
                                  Sabrina
                                  Vanessa
                                  Nadine
                                  Janina
                                  Sandra
                                  Annika
                                  Nina
                                  Stefanie
                                  Stephanie
                                  Franziska
                                  Jana
                                  Katrin
                                  Catrin
                                  Kathrin
                                  Svenja
                                  Kim
                                  Carolin
                                  Caroline
                                  Karoline
                                  Jasmin
                                  Yasmin
                                  Ann
                                  Hannah
                                  Hanna
                                  Isabell
                                  Isabel
                                  Isabelle
                                  Jacqueline
                                  Janin
                                  Janine
                                  Nicole
                                  Lena
                                  Johanna
                                  Alexandra
                                  Lea
                                  Leah
                                ),
              :last_name => %w(
                                  Müller
                                  Schmidt
                                  Schneider
                                  Fischer
                                  Weber
                                  Meyer
                                  Wagner
                                  Becker
                                  Schulz
                                  Hoffmann
                                  Schäfer
                                  Koch
                                  Richter
                                  Klein
                                  Wolf
                                  Schröder
                                  Neumann
                                  Schwarz
                                  Zimmermann
                                  Braun
                                  Krüger
                                  Hofmann
                                  Hartmann
                                  Lange
                                  Schmitt
                                  Werner
                                  Schmitz
                                  Krause
                                  Meier
                                  Lehmann
                                  Schmid
                                  Schulze
                                  Maier
                                  Köhler
                                  Herrmann
                                  König
                                  Walter
                                  Mayer
                                  Huber
                                  Kaiser
                                  Fuchs
                                  Peters
                                  Lang
                                  Scholz
                                  Möller
                                  Weiß
                                  Jung
                                  Hahn
                                  Schubert
                                  Vogel
                                  Friedrich
                                  Keller
                                  Günther
                                  Frank
                                  Berger
                                  Winkler
                                  Roth
                                  Beck
                                  Lorenz
                                  Baumann
                                  Franke
                                  Albrecht
                                  Schuster
                                  Simon
                                  Ludwig
                                  Böhm
                                  Winter
                                  Kraus
                                  Martin
                                  Schumacher
                                  Krämer
                                  Vogt
                                  Stein
                                  Jäger
                                  Otto
                                  Sommer
                                  Groß
                                  Seidel
                                  Heinrich
                                  Brandt
                                  Haas
                                  Schreiber
                                  Graf
                                  Schulte
                                  Dietrich
                                  Ziegler
                                  Kuhn
                                  Kühn
                                  Pohl
                                  Engel
                                  Horn
                                  Busch
                                  Bergmann
                                  Thomas
                                  Voigt
                                  Sauer
                                  Arnold
                                  Wolff
                                  Pfeiffer
              )}
  end

  def name
    "#{first_name} #{last_name}"
  end

  def user_name
    variant = Random.rand(0..5)

    temp_name =  case variant
      when 0 then "#{last_name}_#{first_name}"
      when 1 then last_name.downcase
      when 2 then first_name[0,2].downcase + last_name.downcase
      when 3 then "#{last_name}#{Random.rand(1..100)}"
      else
        "#{first_name[0,2].downcase}_#{last_name.downcase}#{Random.rand(1..100)}"
    end

  end

  # Select random firstname from seeds
  def first_name
    @seeds[:first_name][Random.rand(0..86)]
  end

  # Select random lastname from seeds
  def last_name
    @seeds[:last_name][Random.rand(0..97)]
  end

  def uuid
    SecureRandom.uuid
  end

  def password
    Devise.friendly_token.first(8).gsub("-","A").gsub("=","B").gsub("^","C")
  end

  def prepaid_token
    2.times.map {
      Devise.friendly_token.first(12).gsub("-","A").gsub("=","B").gsub("^","C")
    }
  end
end
