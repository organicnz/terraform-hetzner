#!/bin/bash

# Load environment variables from .env.local
if [ -f .env.local ]; then
  set -a
  source .env.local
  set +a
  echo "Loaded environment variables from .env.local"
else
  echo "Warning: .env.local file not found"
fi

# Run terraform with all arguments passed to this script
terraform "$@" 