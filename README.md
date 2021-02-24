# SwiftRecipes
Final assignment project for the mobile development iOS course (MBDIOS).

## Prerequisites
- XCode 12.4
- iOS 14.4

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