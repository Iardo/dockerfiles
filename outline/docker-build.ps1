#!/usr/bin/env pwsh

# pull the last version of the repository locally
if (-Not (Test-Path -Path outline-main)) {
  Invoke-WebRequest -Uri 'https://github.com/outline/outline/archive/refs/heads/main.zip' -OutFile 'main.zip'
  Expand-Archive -Path 'main.zip' -DestinationPath '.'
  Remove-Item main.zip
  #Copy-Item "Dockerfile" -Destination "./outline-main/Dockerfile" -force
  #Copy-Item "package.json" -Destination "./outline-main/package.json" -force
  Write-Host "done cloning the repo" -f green
}

# force to use BUILDKIT instead of the old Docker build system
$env:DOCKER_BUILDKIT = 1
$env:COMPOSE_DOCKER_CLI_BUILD = 1

docker-compose build --progress=plain --no-cache
docker-compose -f docker-compose.yml up -d

