#!/bin/ruby

if ARGV.length < 2
  puts "please provide the number of nodes to create and the name of the target environment"
  exit
end

ARGV[0].to_i.times do |_i|
  string_length = 8
  hostname = rand(36**string_length).to_s(36)
  File.open("nodes/#{hostname}.betadots.training_facts.yaml", "wx") do |f|
    f.write "---\nfqdn: '#{hostname}.betadots.training'\nrole: 'hdm_test'\nenvironment: '#{ARGV[1]}'\nzone: 'internal'\n"
  end
end
