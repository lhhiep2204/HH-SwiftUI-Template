# HH SwiftUI Template - Simplify Your SwiftUI Project Creation
Welcome to the HH SwiftUI Template! This template is designed to streamline the process of creating new SwiftUI projects, saving you valuable time.

## Contents

- [Setup](#setup)
- [Usage](#usage)
- [License](#license)

## Setup
Getting started is easy! Follow these steps:

1. Copy the `File Templates` and `Project Templates` folders.
2. Navigate to `~/Library/Developer/Xcode/Templates` on your Mac.
3. Paste the copied folders there.

## Usage
Creating new projects and files is now a breeze!
### Create a Project
1. Open Xcode and click on "Create a new Xcode project."
2. Scroll down and select `HH SwiftUI Template` under the `Project Templates` category.
3. Customize your project settings and hit "Create."

<img width="741" alt="Screenshot 2023-07-28 at 14 19 35" src="https://github.com/lhhiep2204/SwiftUI-Combine-MVI/assets/46402339/4500045e-97f7-44d7-a545-defac5a20a0f">

Make sure to update the `[ProjectName]App` struct in the `[ProjectName]App.swift` file with the following snippet to set up your project's routing:

```swift
@ObservedObject private var routerManager = RouterManager(root: .launchScreen)
    
var body: some Scene {
    WindowGroup {
        RouterView(routerManager)
    }
}
```

### Create a File
1. Open Xcode and the project you created using the HH SwiftUI Template.
2. Right-click on the folder where you want to add the new file.
3. Scroll down and choose either `HH View Model File` or `HH SwiftUI File` under the File Templates category.
4. Name the file and start coding!

<img width="746" alt="Screenshot 2023-07-28 at 14 18 27" src="https://github.com/lhhiep2204/SwiftUI-Combine-MVI/assets/46402339/058e1973-7268-479d-92fd-401e1bd1d2f0">

Now you're all set to supercharge your SwiftUI development with the HH SwiftUI Template! Happy coding!

## License
HH SwiftUI Template is released under the MIT license. [See LICENSE](./LICENSE) for details.
