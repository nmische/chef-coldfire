maintainer        "Nathan Mische"
maintainer_email  "nmische@gmail.com"
license           "Apache 2.0"
description       "Installs ColdFire debugging template."
version           "0.1.0"
recipe            "coldfire", "Installs ColdFire debugging template."

%w{ coldfusion10 }.each do |d|
  depends d
end

%w{ ubuntu rhel }.each do |os|
  supports os
end
