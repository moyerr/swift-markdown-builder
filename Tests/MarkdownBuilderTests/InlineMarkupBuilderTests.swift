import Testing
@testable import MarkdownBuilder

@Suite("Inline markup builder tests")
struct InlineMarkupBuilderTests {

    @Test("Build from a single raw string expression")
    func testSingleRawStringExpression() {
        let paragraph = Paragraph {
            "Paragraph has `some code` and an [inline link](https://example.com)"
        }

        let expected = """
            Paragraph
            ├─ Text "Paragraph has "
            ├─ InlineCode `some code`
            ├─ Text " and an "
            └─ Link destination: "https://example.com"
               └─ Text "inline link"
            """

        #expect(paragraph.debugDescription() == expected)
    }

    @Test("Build from multiple raw string expressions")
    func testMultipleRawStringExpressions() {
        let paragraph = Paragraph {
            "Paragraph has `some code` and an"
            "[inline link](https://example.com)"
        }

        let expected = """
            Paragraph
            ├─ Text "Paragraph has "
            ├─ InlineCode `some code`
            ├─ Text " and an"
            └─ Link destination: "https://example.com"
               └─ Text "inline link"
            """

        #expect(paragraph.debugDescription() == expected)
    }

    @Test("Build from a single inline markup expression")
    func testSingleBlockMarkupExpression() {
        let paragraph = Paragraph {
            Link(destination: "https://example.com", Text("Example link"))
        }

        let expected = """
            Paragraph
            └─ Link destination: "https://example.com"
               └─ Text "Example link"
            """

        #expect(paragraph.debugDescription() == expected)
    }

    @Test("Build from multiple inline markup expressions")
    func testMultipleBlockMarkupExpressions() {
        let paragraph = Paragraph {
            Text("Example text")
            Link(destination: "https://example.com", Text("Example link"))
        }

        let expected = """
            Paragraph
            ├─ Text "Example text"
            └─ Link destination: "https://example.com"
               └─ Text "Example link"
            """

        #expect(paragraph.debugDescription() == expected)
    }

    @Test("Build inline markup with simple if block", arguments: [true, false])
    func testIfBlock(_ showText: Bool) {
        let paragraph = Paragraph {
            if showText {
                Text("Example text")
            }

            Link(destination: "https://example.com", Text("Example link"))
        }

        let expected = showText ? """
            Paragraph
            ├─ Text "Example text"
            └─ Link destination: "https://example.com"
               └─ Text "Example link"
            """ : """
            Paragraph
            └─ Link destination: "https://example.com"
               └─ Text "Example link"
            """

        #expect(paragraph.debugDescription() == expected)
    }

    @Test("Build inline markup with if/else blocks", arguments: [true, false])
    func testIfElseBlocks(_ useHardLineBreak: Bool) {
        let paragraph = Paragraph {
            Text("First line")

            if useHardLineBreak {
                LineBreak()
            } else {
                SoftBreak()
            }

            Text("Second line")
        }

        let expected = useHardLineBreak ? """
            Paragraph
            ├─ Text "First line"
            ├─ LineBreak
            └─ Text "Second line"
            """ : """
            Paragraph
            ├─ Text "First line"
            ├─ SoftBreak
            └─ Text "Second line"
            """

        #expect(paragraph.debugDescription() == expected)
    }

    @Test("Build inline markup using a for-loop")
    func testForLoops() {
        let paragraph = Paragraph {
            for i in 1...4 {
                Text("Item #\(i)")
                LineBreak()
            }
        }

        let expected = """
            Paragraph
            ├─ Text "Item #1"
            ├─ LineBreak
            ├─ Text "Item #2"
            ├─ LineBreak
            ├─ Text "Item #3"
            ├─ LineBreak
            ├─ Text "Item #4"
            └─ LineBreak
            """

        #expect(paragraph.debugDescription() == expected)
    }

    @Test(
        "Ensure inline elements built from raw strings have no parent",
        Comment("""
            Inline elements built from raw strings are parsed using the the Document(parsing:) \
            initializer. The individual blocks returned by the result builder should \
            not reference that Document as their parent.
            """
        )
    )
    func testRawStringsProduceBlocksWithoutParents() {
        @InlineMarkupBuilder
        var results: [any InlineMarkup] {
            """
            First line has **strong text** and _emphasized text_
            Second line has `some code` and an [inline link](https://example.com)
            """
        }

        #expect(results.count == 9)

        for child in results {
            #expect(child.parent == nil, "Inline elements returned by the builder should have no parent")

            for descendant in child.children {
                #expect(
                    descendant.parent != nil,
                    "Descendents of the inline elements should maintain their parent-child relationship."
                )
            }
        }
    }
}
