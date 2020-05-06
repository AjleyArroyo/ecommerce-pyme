
server '3.21.124.60', user: 'deploy', roles: %w{app db web}

set :stage,           :production
set :branch,          "master"


