class Employee < ActiveRecord::Base

  has_paper_trail

  include UserConcern
  include PersonConcern

end
