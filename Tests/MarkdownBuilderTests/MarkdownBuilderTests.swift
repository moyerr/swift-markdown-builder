import Testing
@testable import MarkdownBuilder

@Test func example() async throws {
    let document = Document {
        Heading(level: 2) {
            Text("Heading!")
        }

        Paragraph {
            Text("First Paragraph")
            SoftBreak()
            Text("wow")
        }

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
                ListItem { Paragraph(Text("Item \(i)")) }
            }
        }
    }

    print(document.format())
}
