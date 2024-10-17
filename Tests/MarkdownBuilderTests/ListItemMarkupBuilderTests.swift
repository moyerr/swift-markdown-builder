import Testing
@testable import MarkdownBuilder

@Suite("List item markup builder tests")
struct ListItemMarkupBuilderTests {

    @Test("Build from single list item")
    func testSingleListItem() {
        let list = UnorderedList {
            ListItem { Text("First item") }
        }

        let expected = """
            UnorderedList
            └─ ListItem
               └─ Paragraph
                  └─ Text "First item"
            """

        #expect(list.debugDescription() == expected)
    }

    @Test("Build from multiple list items")
    func testMultipleListItems() {
        let list = UnorderedList {
            ListItem { Text("First item") }
            ListItem { Text("Second item") }
        }

        let expected = """
            UnorderedList
            ├─ ListItem
            │  └─ Paragraph
            │     └─ Text "First item"
            └─ ListItem
               └─ Paragraph
                  └─ Text "Second item"
            """

        #expect(list.debugDescription() == expected)
    }

    @Test("Build list with simple if block", arguments: [true, false])
    func testIfBlock(_ showFirstItem: Bool) {
        let list = UnorderedList {
            if showFirstItem {
                ListItem { Text("First item") }
            }

            ListItem { Text("Second item") }
        }

        let expected = showFirstItem ? """
            UnorderedList
            ├─ ListItem
            │  └─ Paragraph
            │     └─ Text "First item"
            └─ ListItem
               └─ Paragraph
                  └─ Text "Second item"
            """ : """
            UnorderedList
            └─ ListItem
               └─ Paragraph
                  └─ Text "Second item"
            """

        #expect(list.debugDescription() == expected)
    }

    @Test("Build list with if/else blocks", arguments: [true, false])
    func testIfElseBlocks(_ condition: Bool) {
        let list = UnorderedList {
            if condition {
                ListItem { Text("True item") }
            } else {
                ListItem { Text("False item") }
            }
        }

        let expected = condition ? """
            UnorderedList
            └─ ListItem
               └─ Paragraph
                  └─ Text "True item"
            """ : """
            UnorderedList
            └─ ListItem
               └─ Paragraph
                  └─ Text "False item"
            """

        #expect(list.debugDescription() == expected)
    }

    @Test("Build list with a for-loop")
    func testForLoops() {
        let list = UnorderedList {
            for i in 1 ... 4 {
                ListItem { Text("Item \(i)") }
            }
        }

        let expected = """
            UnorderedList
            ├─ ListItem
            │  └─ Paragraph
            │     └─ Text "Item 1"
            ├─ ListItem
            │  └─ Paragraph
            │     └─ Text "Item 2"
            ├─ ListItem
            │  └─ Paragraph
            │     └─ Text "Item 3"
            └─ ListItem
               └─ Paragraph
                  └─ Text "Item 4"
            """

        #expect(list.debugDescription() == expected)
    }
}
