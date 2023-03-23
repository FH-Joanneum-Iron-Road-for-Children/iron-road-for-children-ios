# Iron Road for Children iOS App (IRFC) 

## 💻 Setup prerequisites
**Ruby** version `2.7.x` or above is required. We strongly recommend using [rbenv](https://github.com/rbenv/rbenv) for installing different ruby versions.

**Xcode** `14.2` or above is required for development.

### Others (Installed with setup.sh script)
**Xcodegen** This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) for generating the Xcode project.

**SwiftFormat** We automatically format our Swift code on every commit.

**SwiftLint** SwiftLint will be executed in the CI to check Swift code.

## 🚀 Getting started
First of all install all needed dependencies and git hooks. Execute follwing script:
```bash
./setup.sh
```

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

## 📚 Documentation
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

The `start_ci` lane does all the magic for you. It increases the build number by one if no other parameters are provided
```bash
bundle exec fastlane start_ci
```

If you only want to update the version and automatically increase the build number use following command
```bash
bundle exec fastlane start_ci v:2.0.0
```

If you want to override both use
```bash
bundle exec fastlane start_ci v:2.0.0 b:123
```

#### Certificates
Certificates are automatically handled by fastlane. The profiles and the certificates are stored in a separate repository on GitHub.

If one of the certificates is invalid, revoke all app signing certificates and profile on the Apple Developer Account as well as in the private repository.

After cleaning up the repo and the Apple Developer Account trigger a new build, the certificates will be automatically renewed