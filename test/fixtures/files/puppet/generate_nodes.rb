#!/bin/ruby

if ARGV.length < 1
  puts "please provide the number of nodes to create"
  exit
end

i = 0
while i < ARGV[0].to_i
  string_length = 8
  hostname = rand(36**string_length).to_s(36)
  File.open("nodes/#{hostname}.example42.training_facts.yaml", "w") { |f|
    f.write "---\nfqdn: '#{hostname}.betadots.training'\nrole: 'hdm_test'\nenv: 'demo'\nzone: 'internal'\n"
  }
  i += 1
end
