require_relative "../../config/environment"

class FakePuppetDB
  def initialize(*)
    super
    @config_dir = Rails.configuration.hdm["config_dir"]
  end

  def call(env)
    request = Rack::Request.new(env)
    case request.path
    when "/pdb/query/v4/environments"
      environments
    when "/pdb/query/v4/nodes"
      nodes
    when "/pdb/query/v4/facts"
      facts(request.params["query"])
    else
      [404, {}, ["Not Found"]]
    end
  end

  private

  def environments
    environments_full_path = Dir.glob(Pathname.new(@config_dir).join("environments", "*"))
    environments = environments_full_path.map { |x| File.basename(x) }.sort
      .map { |e| {"name" => e} }
    respond_with(environments)
  end

  def nodes
    nodes = Dir.glob(Pathname.new(@config_dir).join("environments", environment).join("nodes", "*.yaml"))
      .map { |f| File.basename(f, ".yaml").sub("_facts", "") }
      .map { |n| {"certname" => n} }
    respond_with(nodes)
  end

  def facts(query)
    host = JSON.parse(query).find { |e| e.is_a?(Array) && e[1] == "certname" }[2]
    facts = YAML.load(
      File.read(Pathname.new(@config_dir).join("nodes", "#{host}_facts.yaml"))
    )
    response = facts.map { |k, v| {"name" => k, "value" => v} }
    respond_with(response)
  end

  def respond_with(data)
    [200, {"Content-Type" => "application/json"}, [data.to_json]]
  end
end
