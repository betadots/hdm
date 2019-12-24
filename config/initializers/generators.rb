Rails.application.configure do
  config.generators do |g|
    g.template_engine false
    g.stylesheets     false
    g.javascripts     false
    g.helper          false
    g.jbuilder        false
  end
end
