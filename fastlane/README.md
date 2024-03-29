fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios test

```sh
[bundle exec] fastlane ios test
```

Run all iOS unit and ui tests.

### ios sync_certificates

```sh
[bundle exec] fastlane ios sync_certificates
```

Sync certificates

### ios release_irfc

```sh
[bundle exec] fastlane ios release_irfc
```



### ios release_irfc_beta

```sh
[bundle exec] fastlane ios release_irfc_beta
```



### ios start_ci

```sh
[bundle exec] fastlane ios start_ci
```

Updates build number and version. Creates a new tag based on those and pushes it to origin

### ios new_build_number_yml

```sh
[bundle exec] fastlane ios new_build_number_yml
```

Updates build number in project.yml. If no ':b' parameter is provided, the existing number will be increased by 1

### ios new_version_yml

```sh
[bundle exec] fastlane ios new_version_yml
```

Updates build number in project.yml. If no ':v' parameter is provided, the existing version will be used.

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
