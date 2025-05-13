<h3 align="center">
  <a href="https://github.com/FH-Joanneum-Iron-Road-for-Children/.github/blob/develop/profile/images/logo.png">
    <img src="https://github.com/FH-Joanneum-Iron-Road-for-Children/.github/blob/develop/profile/images/logo.png" alt="IRFC Logo" width="250" style="border-radius: 50px;">
  </a>
</h3>

# Iron Road for Children iOS App (IRFC)

The official iOS application for the Iron Road for Children (IRFC) festival, Austria's largest open-brand festival weekend for bikes, Vespas, and US cars. Under the motto "Ein Herz für Kinder - Benzin im Blut" (A heart for children - gasoline in the blood), the festival collects donations for children in need across Austria. Entry to the entire event weekend is free, with all proceeds going directly to children's charities. This app provides festival attendees with event schedules, a simple pdf map, gallery access, voting capabilities and more.

## 🎮 App Features

- **Festival Schedule**: Browse through event listings sorted by day and category
- **Interactive Pdf Map**: Navigate the festival grounds efficiently
- **Photo Gallery**: View festival images and artwork
- **Voting System**: Participate in festival voting competitions
- **Countdown Timer**: Stay updated with the time remaining until the festival begins
- **Playlist Integration**: Access the festival's Spotify playlist directly within the app
- **Offline Support**: Core functionality works without constant internet connection
- **Notification System**: Get reminders for your favorite artists/events

## 💻 Development Setup

### Prerequisites

- **Ruby** version `2.7.x` or above (we recommend using [rbenv](https://github.com/rbenv/rbenv) for Ruby version management)
- **Xcode** `14.2` or above
- **Git** for version control

### Tools (Installed via setup.sh)

- **XcodeGen**: Generates the Xcode project from a specification file
- **SwiftFormat**: Automatically formats Swift code
- **SwiftLint**: Enforces Swift style and conventions

### Getting Started

1. Clone the repository and navigate to the project directory
2. Run the setup script to install dependencies and git hooks:
   ```bash
   ./setup.sh
   ```

3. Install Ruby dependencies:
   ```bash
   bundle install
   ```
   > Note: The generated `Gemfile.lock` must be committed. Do NOT modify it manually.

4. Generate the Xcode project:
   ```bash
   xcodegen
   ```
   > Important: Run this command after switching branches or pulling from remote.

5. Open the project in Xcode:
   ```bash
   open IronRoadForChildren.xcodeproj
   ```

## 🏗️ Project Architecture

This app follows the MVVM (Model-View-ViewModel) architecture and is built with Swift and SwiftUI. It uses Swift Package Manager for modular dependency management.

### Project Structure
```
IRFC/
├── IronRoadForChildren/     # Main application code
│   ├── Features/            # Feature modules (Home, Program, Voting, etc.)
│   ├── Utils/               # Utility functions and extensions
│   └── SupportingFiles/     # App resources like LaunchScreen and configuration
├── Packages/                # Swift packages
│   ├── CoreUI/              # UI components and styling
│   ├── Networking/          # API communication layer
│   └── ExampleMVVM/         # MVVM architecture example
├── Targets/                 # Environment-specific configurations
│   ├── Prod/                # Production environment
│   └── Beta/                # Beta/Testing environment
├── fastlane/               # Deployment automation scripts
└── command-line-tools/     # Development utility scripts
```

### MVVM Pattern

- **Models**: Data and business logic (see `EventModel.swift`, `VotesModel.swift`)
- **Views**: UI components and layouts (see `ContentView.swift`, feature-specific views)
- **ViewModels**: Connects Models and Views, handles UI logic (see `ProgramViewModel.swift`)

An example implementation can be found in the [ExampleMVVM](Packages/ExampleMVVM/) folder.

### Key Packages
- **CoreUI**: Common UI components and extensions
- **Networking**: API communication layer
- **ExampleMVVM**: Sample implementation of the MVVM pattern
- **External Dependencies**: AsyncAlgorithms, SimpleKeychain, AckGen, Nuke

### Multiple Targets
The app has two targets with separate configurations:
- **IronRoadForChildren**: Production environment
- **IronRoadForChildrenBeta**: Testing environment

Configuration settings are defined in:
- `Targets/Prod/Config.swift`
- `Targets/Beta/Config.swift`

When adding new configuration properties, add them to the `BaseConfig` protocol first, then implement them in both environment-specific Config files.

## 🚀 Deployment

### Testing
Run the automated test suite:
```bash
bundle exec fastlane test
```

### Create build for TestFlight

#### Prerequisites

- Repository Owner Role (only team lead): Required for creating version tags via fastlane
- Apple Developer Account: With appropriate permissions

To create a build with an automatically incremented build number:
```bash
bundle exec fastlane start_ci
```

To update the version and increment the build number:
```bash
bundle exec fastlane start_ci v:2.0.0
```

To specify both version and build number:
```bash
bundle exec fastlane start_ci v:2.0.0 b:123
```

### Certificate Management
Certificates are automatically handled by Fastlane. The provisioning profiles and certificates are stored in a separate GitHub repository.

If encountering certificate issues:
1. Revoke all app signing certificates and profiles in the Apple Developer Account
2. Clean up the certificates in the private repository
3. Trigger a new build - certificates will be automatically renewed

## 📘 Components

### Main Tabs
- **Home**: Festival information and countdown timer
- **Program**: Event schedule with filtering by day and category
- **Voting**: Participate in various festival voting competitions
- **Map**: Navigate the festival grounds
- **More**: Additional information, gallery, settings, playlist, donate etc.

## 🤝 Contributing

Contributions are managed through GitHub. Please follow these practices:
- Use feature branches for development
- Run SwiftFormat and SwiftLint before committing
- Make sure you run `xcodegen` after pulling changes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Credits

Developed by students from FH JOANNEUM's Mobile Software Development program in collaboration with the Iron Road for Children festival organization (Brainsworld Agency).