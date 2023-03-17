#!/bin/bash

# Set the YML file path
YML_FILE="project.yml"

# Set the variable name to extract
VERSION="CFBundleShortVersionString"
BUILD="CFBundleVersion"

# Extract the value of the variable
VERSION_VALUE=$(grep -i "^ *$VERSION:" $YML_FILE | sed 's/^ *//;s/ *: */: /' | cut -d ':' -f 2- | sed -e 's/^ *//' -e 's/ *$//' -e 's/^["'\'']\|["'\'']$//g')
BUILD_VALUE=$(grep -i "^ *$BUILD:" $YML_FILE | sed 's/^ *//;s/ *: */: /' | cut -d ':' -f 2- | sed -e 's/^ *//' -e 's/ *$//' -e 's/^["'\'']\|["'\'']$//g')

# Set the tag name and commit message
TAG_NAME=${VERSION_VALUE//\"}-b${BUILD_VALUE//\"}
COMMIT_MESSAGE="Tagging version $TAG_NAME"

echo Creating a new tag $TAG_NAME

# Create the tag and push it to the remote repository
git tag -a $TAG_NAME -m "$COMMIT_MESSAGE"
git push origin $TAG_NAME