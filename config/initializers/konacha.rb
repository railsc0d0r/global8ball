if defined?(Konacha)
  Konacha.configure do |config|
    config.spec_dir     = "spec/javascripts"
    config.spec_matcher = /_spec\.|_test\./
    config.driver       = :selenium
  end

  # Disable paper trail for specs controller. Paper trail enables itself for
  # all controllers by default, causing the specs to error out when trying to get
  # the "current user".
  Konacha::SpecsController.class_eval do
    def paper_trail_enabled_for_controller
      false
    end
  end
end
