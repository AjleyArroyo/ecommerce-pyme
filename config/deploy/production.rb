
server '3.12.202.25', user: 'deploy', roles: %w{app db web}

set :stage,           :production
set :branch,          "master"


