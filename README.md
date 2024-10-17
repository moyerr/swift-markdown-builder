# Swift Markdown Builder

Swift `MarkdownBuilder` is a package that provides a result-builder DSL for [`swift-markdown`](https://github.com/swiftlang/swift-markdown). The [documentation](https://swiftpackageindex.com/swiftlang/swift-markdown/documentation/markdown) for the `swift-markdown` package provides detailed examples for creating Markdown documents programmatically. This package builds on that foundation by providing a more natural DSL that will feel familiar to users of SwiftUI and other result builder DSLs.

## Usage Examples

#### Using control flow statements

The DSL allows you to create Markdown documents using standard Swift control flow statments. For example, you can generate an ordered list using a for-loop:

```swift
let groceries = [
    "Milk",
    "Eggs",
    "Bread",
]

let groceryList = Document {
    Heading(level: 2) {
        "Grocery List"
    }

    OrderedList {
        for item in groceries {
            ListItem(Text(item))
        }
    }
}
```

#### TODO: More examples coming soon

> [!NOTE]
> This README was generated using `MarkdownBuilder`. Do not edit it directly. Instead, edit the file at `Sources/create-readme/main.swift` and run `swift run create-readme` to regenerate it.