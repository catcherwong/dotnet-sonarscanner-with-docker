#!/bin/bash

set -x

PROJECT_KEY="${PROJECT_KEY:-ConsoleApplication1}"
PROJECT_PATH="${PROJECT_PATH:-.}"
SONAR_HOST="${HOST:-http://localhost:9000}"
SONAR_LOGIN_KEY="${LOGIN_KEY:-admin}"

# install the newest dotnet-sonarscanner
dotnet tool install --global dotnet-sonarscanner
export PATH="$PATH:$HOME/.dotnet/tools/"

# restore with nuget.config
dotnet restore "${PROJECT_PATH}" --configfile /project/nuget.config

# execute scanner
dotnet sonarscanner begin /k:"${PROJECT_KEY}" /d:sonar.host.url="${SONAR_HOST}"  /d:sonar.login="${SONAR_LOGIN_KEY}"
dotnet build "${PROJECT_PATH}"
dotnet sonarscanner end /d:sonar.login="${SONAR_LOGIN_KEY}"