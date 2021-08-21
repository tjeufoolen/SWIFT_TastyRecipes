# SwiftRecipes
This is the first app I have written using Swift.

## Prerequisites
- XCode 12.4
- iOS 14.4
- [Tasty API Token](https://rapidapi.com/apidojo/api/tasty/endpoints)

## Getting Started
1. Clone this project
2. Open project with XCode
3. Specify tasty api token inside `SwiftRecipes/Configs/Development.xcconfig`
4. Build the project and enjoy! :tada:

## TastyAPI class usage
Retrieve one single recipe
```swift
TastyAPI().fetchSingleRecipe(id: 7109) { recipe in
    if let recipe = recipe {
        print(recipe)
    }
}
```

Retrieve first 20 recipes that are under 30 minutes to make
```swift
TastyAPI().fetchRecipes(query: "from=0&size=20&tags=under_30_minutes") { recipes in
    print(recipes)
}
```

## Author
- [Tjeu Foolen](https://github.com/tjeufoolen)

## Source references
- [Ultimate Guide to JSON Parsing with Swift](https://benscheirman.com/2017/06/swift-json/)
- [function with dataTask returning a value](https://stackoverflow.com/questions/40014830/function-with-datatask-returning-a-value)
- [What is escaping closure and when to use it](https://fluffy.es/what-is-escaping-closure/)
- [Let's Set Up Your iOS Environments](https://thoughtbot.com/blog/let-s-setup-your-ios-environments)
- [How to turn XCode color assets (.xcassets) into UIColor extension](https://medium.com/flawless-app-stories/how-to-turn-xcode-color-assets-xcassets-into-uicolor-extension-3dc28953d4d3)
- [Creating the basic UI: UITabBarController – Whitehouse Petitions, part 2](https://www.youtube.com/watch?v=7iuRj8YNAxM&feature=emb_logo)
- [How to repeat a string](https://www.hackingwithswift.com/example-code/strings/how-to-repeat-a-string)
- [Computed Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)
- [Adding a Custom Font to Your App](https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app)
- [Change tab bar item selected color in a storyboard](https://stackoverflow.com/questions/26835148/change-tab-bar-item-selected-color-in-a-storyboard)
- [Change color of Back button in navigation bar](https://stackoverflow.com/questions/28733936/change-color-of-back-button-in-navigation-bar)
- [Adding Padding To A Stack View](https://useyourloaf.com/blog/adding-padding-to-a-stack-view/)
- [UIScrollView with Content Layout Guides](https://spin.atomicobject.com/2020/03/23/uiscrollview-content-layout-guides/)
- [Creating a Free Form View Controller](https://guides.codepath.com/ios/Creating-a-Free-Form-View-Controller)
- [How to add Padding in UILabel in iOS using Swift](https://johncodeos.com/how-to-add-padding-in-uilabel-in-ios-using-swift/)
- [Loading/Downloading image from URL on Swift](https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift)
- [How to Store a Custom Object in User Defaults in Swift](https://cocoacasts.com/ud-5-how-to-store-a-custom-object-in-user-defaults-in-swift)
