#!/bin/bash
set -e
set -o pipefail

su postgres
createuser -W openproject
createdb -O openproject openproject
