#!/bin/ruby

if ARGV.length < 1
  puts "please provide the number of nodes to create"
  exit
end

i = 0
while i < ARGV[0].to_i
  string_length = 8
  entry = rand(36**string_length).to_s(36)
  crypt = %x(bundle exec eyaml encrypt -o block -s #{entry})
  File.open('data/common.yaml', 'a') { |f|
    f.write "#{entry}: >\n#{crypt}\n\n"
  }
  i += 1
end
