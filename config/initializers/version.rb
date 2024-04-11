Hdm::VERSION =
  if system("git --version >>/dev/null 2>&1")
    `git describe`.chomp
  else
    "unknown"
  end
