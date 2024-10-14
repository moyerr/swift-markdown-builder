import Testing
@testable import MarkdownBuilder

@Test func example() async throws {
    let document = Document {
        Heading(level: 2) {
            Text("Result builders")
        }

        Paragraph {
            "Declare them by decorating a type with "
            InlineCode("@resultBuilder")
        }

        Paragraph {
            "First Paragraph has `some Code` and it is **legit**"
            SoftBreak()
            Text("wow")
            LineBreak()
            Link(destination: "https://www.apple.com/") {
                "**`some bold code`** and normal text"
            }
        }

        "Second Paragraph `has some code` and an <a href=http://www.apple.com/>inline link</a>"

        "<img width=280 src=http://example.com/img.jpg>"

        CodeBlock(language: "swift") {
            """
            protocol View: {
              associatedtype Body
              var body: Body { get }
            }
            """
        }

        OrderedList {
            for i in 1 ... 10 {
                ListItem { "Item \(i)" }
            }
        }

        UnorderedList {
            for i in 11 ... 20 {
                ListItem {
                    "Item \(i)"
                }
            }
        }
    }

    print(document.format())
    print("-----------")
    print(document.debugDescription())
}
