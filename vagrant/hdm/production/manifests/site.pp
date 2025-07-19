File {
  backup => false,
}
$classes_hash = lookup('classes', { 'value_type' => Hash, 'default_value' => {} })
$classes_hash.keys.sort.each |$key| {
  if $classes_hash[$key] != '' {
    contain $classes_hash[$key]
  } else {
    echo { $key:
      message  => "Class for ${key} on ${facts['networking']['fqdn']} is disabled",
      withpath => false,
    }
  }
}
node default {}
