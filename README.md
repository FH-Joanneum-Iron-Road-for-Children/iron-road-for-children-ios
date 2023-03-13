# Iron Road for Children iOS App (IRFC) 

## Prerequisites
**Ruby** version `2.7.x` or above is required. We strongly recommend using [rbenv](https://github.com/rbenv/rbenv) for installing different ruby versions.

**Xcode** `14.2` or above is required for development.

**Xcodegen** This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) for generating the Xcode project.
If not installed, you can install XcodeGen using brew:
```bash
brew install xcodegen
```

## Getting started
For ruby dependencies we use `Gemfile` to ensure that all developers use the same versions of software tools like Fastlane.
To install all the dependencies run follwoing command:
```bash
bundle install
```
The generated `Gemfile.lock` must be commited always. Never touch this file manually.

Generate the Xcode project (run in root folder, where the project.yml lives):
```bash
xcodegen
```

This command must also be run after switching branches and it's advisable to also run it after a git pull.

Open the IronRoadForChildren.xcodeproj in Xcode and start coding 💻😃 

## Documentation
### MVVM Example
An MVVM Example can be found in [ExampleMVVM](Packages/ExampleMVVM/) folder.

### Fastlane
[Fastlane](https://github.com/fastlane/fastlane) is our app automation tool. 

#### Testing
To run all tests of IRFC run following command in terminal
```bash
bundle exec fastlane test
```

#### Create build for Testflight
TODO