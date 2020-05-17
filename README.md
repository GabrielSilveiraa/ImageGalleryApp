# ImageGalleryApp

[![Build Status](https://travis-ci.com/GabrielSilveiraa/ImageGalleryApp.svg?token=7saYWsx5v6apX8usgxcf&branch=master)](https://travis-ci.com/GabrielSilveiraa/ImageGalleryApp) [![codecov](https://codecov.io/gh/GabrielSilveiraa/ImageGalleryApp/branch/develop/graph/badge.svg?token=NY3065LPW2)](https://codecov.io/gh/GabrielSilveiraa/ImageGalleryApp)

## Installation

### Installing Pods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website.

### Installing project's dependencies
Navigate to the root directory of this project in Terminal (the directory that contains the .xcodeproj file).

Run on terminal:
```
$ pod install
```

### Running the project
Open the .xcworkspace file and run

## Architecture

The project's architecture is MVVM-C. The MVVM presentation pattern using Coordinators to route the app.

The app is built in Features, composed by a Coordinator and Scenes.
The Coordinator is responsible for a specific flow or story, so it may be responsible for one or more Scenes.

Every Scene is developed using the MVVM presentation architecture, along with a view coded layer and a service class for any network request.

## Dependencies

### Service layer

* [GMSNetworkLayer](https://github.com/GabrielSilveiraa/GMSNetworkLayer)

A framework developed by me to facilitate the http networking in Swift.

### Reactive Programming

* [RxSwift](https://github.com/ReactiveX/RxSwift)

### Image downloading anc caching

* [Kingfisher](https://github.com/onevcat/Kingfisher)

### Tests

* [Nimble](https://github.com/Quick/Nimble)
* [Quick](https://github.com/Quick/Quick)
