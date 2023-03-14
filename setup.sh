#!/bin/bash
# Check if homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "homebrew not found. Please install it first."
    exit 1
fi

# Check if homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "homebrew not found. Please install it first."
    exit 1
fi


brew install xcodegen
brew install swiftlint
brew install swiftformat

echo ""

echo "Removing current git pre-commit hook ..."
rm -rf .git/hooks/pre-commit
echo "Installing git pre-commit hook ..."
cp command-line-tools/pre-commit .git/hooks/pre-commit
