class MoveDateOfBirthToPlayer < ActiveRecord::Migration[5.0]
  def up
    add_column :players, :date_of_birth, :date
    Player.all.each do |p|
      p.update_attribute('date_of_birth', p.person.date_of_birth)
    end
    remove_column :people, :date_of_birth
  end

  def down
    add_column :people, :date_of_birth, :date
    Player.all.each do |p|
      p.person.update_attribute('date_of_birth', p.date_of_birth)
    end
    remove_column :players, :date_of_birth
  end
end
