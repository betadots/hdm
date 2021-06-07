require_relative "../../config/environment"

class FakePuppetDB
  def initialize(*)
    super
    @config_dir = Rails.configuration.hdm["config_dir"]
  end

  def call(env)
    request = Rack::Request.new(env)
    query = parsed_query(request.params["query"])
    case request.path
    when "/pdb/query/v4/environments"
      environments
    when "/pdb/query/v4/inventory"
      nodes(query)
    when "/pdb/query/v4/facts"
      facts(query)
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

  def nodes(query)
    environment = query["environment"]
    nodes = Dir.glob(Pathname.new(@config_dir).join("environments", environment).join("nodes", "*.yaml"))
      .map { |f| File.basename(f, ".yaml").sub("_facts", "") }
      .map { |n| {"certname" => n} }
    respond_with(nodes)
  end

  def facts(query)
    host = query["certname"]
    environment = query["environment"]
    facts = YAML.load(
      File.read(Pathname.new(@config_dir).join("environments", environment, "nodes", "#{host}_facts.yaml"))
    )
    response = facts.map { |k, v| {"name" => k, "value" => v} }
    respond_with(response)
  end

  def respond_with(data)
    [200, {"Content-Type" => "application/json"}, [data.to_json]]
  end

  # This does not actually parse any puppet db query. Instead
  # it assumes simple equality tests combined with AND
  def parsed_query(query)
    query ||= "null"
    query = JSON.parse(query)
    return {} unless query.is_a?(Array)
    terms = query.select { |e| e.is_a?(Array) }
    Hash[terms.map { |e| e[1,2] }]
  end
end
