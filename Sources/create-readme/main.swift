import Foundation
import MarkdownBuilder

let readme = Document {
    Heading(level: 1) {
        "Swift Markdown Builder"
    }

    Paragraph {
        """
        Swift `MarkdownBuilder` is a Swift package that provides a result-builder DSL \
        on top of [`swift-markdown`](https://github.com/swiftlang/swift-markdown).
        """
    }

    CodeBlock {
        "version 2"
    }
}.format()

FileManager.default.createFile(
    atPath: "README.md",
    contents: Data(readme.utf8)
)
