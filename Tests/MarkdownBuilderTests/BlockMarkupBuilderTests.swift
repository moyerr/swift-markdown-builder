import Testing
@testable import MarkdownBuilder

@Suite("Block markup builder tests")
struct BlockMarkupBuilderTests {

    @Test("Build from a single raw string expression")
    func testSingleRawStringExpression() {
        let document = Document {
            """
            ## Heading has **strong text** and _emphasized text_

            Paragraph has `some code` and an [inline link](https://example.com)
            """
        }

        let expected = """
            Document
            ├─ Heading level: 2
            │  ├─ Text "Heading has "
            │  ├─ Strong
            │  │  └─ Text "strong text"
            │  ├─ Text " and "
            │  └─ Emphasis
            │     └─ Text "emphasized text"
            └─ Paragraph
               ├─ Text "Paragraph has "
               ├─ InlineCode `some code`
               ├─ Text " and an "
               └─ Link destination: "https://example.com"
                  └─ Text "inline link"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test("Build from multiple raw string expressions")
    func testMultipleRawStringExpressions() {
        let document = Document {
            "## Heading has **strong text** and _emphasized text_"
            "Paragraph has `some code` and an [inline link](https://example.com)"
        }

        let expected = """
            Document
            ├─ Heading level: 2
            │  ├─ Text "Heading has "
            │  ├─ Strong
            │  │  └─ Text "strong text"
            │  ├─ Text " and "
            │  └─ Emphasis
            │     └─ Text "emphasized text"
            └─ Paragraph
               ├─ Text "Paragraph has "
               ├─ InlineCode `some code`
               ├─ Text " and an "
               └─ Link destination: "https://example.com"
                  └─ Text "inline link"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test(
        "Build from inline markup expressions",
        Comment("Inline markup elements are automatically wrapped in a Paragraph as the default block container")
    )
    func testInlineMarkupExpressions() {
        let document = Document {
            Text("Example text")
            Link(destination: "https://example.com", Text("Example link"))
        }

        let expected = """
            Document
            ├─ Paragraph
            │  └─ Text "Example text"
            └─ Paragraph
               └─ Link destination: "https://example.com"
                  └─ Text "Example link"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test("Build from a single block markup expression")
    func testSingleBlockMarkupExpression() {
        let document = Document {
            Heading(level: 2, Text("Example heading"))
        }

        let expected = """
            Document
            └─ Heading level: 2
               └─ Text "Example heading"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test("Build from multiple block markup expressions")
    func testMultipleBlockMarkupExpressions() {
        let document = Document {
            Heading(level: 2, Text("Example heading"))
            Paragraph(Text("Paragraph with "), Strong(Text("strong text")))
        }

        let expected = """
            Document
            ├─ Heading level: 2
            │  └─ Text "Example heading"
            └─ Paragraph
               ├─ Text "Paragraph with "
               └─ Strong
                  └─ Text "strong text"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test("Build block markup with simple if block", arguments: [true, false])
    func testIfBlock(_ showHeading: Bool) {
        let document = Document {
            if showHeading {
                Heading(level: 2, Text("Example heading"))
            }

            Paragraph(Text("This is a paragraph"))
        }

        let expected =  showHeading ? """
            Document
            ├─ Heading level: 2
            │  └─ Text "Example heading"
            └─ Paragraph
               └─ Text "This is a paragraph"
            """ : """
            Document
            └─ Paragraph
               └─ Text "This is a paragraph"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test("Build block markup with if/else blocks", arguments: [true, false])
    func testIfElseBlocks(_ showBigHeading: Bool) {
        let document = Document {
            if showBigHeading {
                Heading(level: 1, Text("Big heading"))
            } else {
                Heading(level: 3, Text("Small heading"))
            }

            Paragraph(Text("This is a paragraph"))
        }

        let expected =  showBigHeading ? """
            Document
            ├─ Heading level: 1
            │  └─ Text "Big heading"
            └─ Paragraph
               └─ Text "This is a paragraph"
            """ : """
            Document
            ├─ Heading level: 3
            │  └─ Text "Small heading"
            └─ Paragraph
               └─ Text "This is a paragraph"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test("Build block markup using a for-loop")
    func testForLoops() {
        let document = Document {
            for i in 1...4 {
                Heading(level: i, Text("Heading #\(i)"))
            }
        }

        let expected = """
            Document
            ├─ Heading level: 1
            │  └─ Text "Heading #1"
            ├─ Heading level: 2
            │  └─ Text "Heading #2"
            ├─ Heading level: 3
            │  └─ Text "Heading #3"
            └─ Heading level: 4
               └─ Text "Heading #4"
            """

        #expect(document.debugDescription() == expected)
    }

    @Test(
        "Ensure blocks built from raw strings have no parent",
        Comment("""
            Blocks built from raw strings are parsed using the the Document(parsing:) \
            initializer. The individual blocks returned by the result builder should \
            not reference that Document as their parent.
            """
        )
    )
    func testRawStringsProduceBlocksWithoutParents() {
        @BlockMarkupBuilder
        var results: [any BlockMarkup] {
            """
            ## Heading has **strong text** and _emphasized text_

            Paragraph has `some code` and an [inline link](https://example.com)

            > This is a block quote

             1. Ordered
             2. List

            ----------

             - Unordered
             - List

            ```swift
            let tests = "passed"
            ```

            | Column 1 | Column 2 |
            | :---: | :---: |
            | item | item |
            """
        }

        #expect(results.count == 8)

        for child in results {
            #expect(child.parent == nil, "Blocks returned by the builder should have no parent")

            for descendant in child.children {
                #expect(
                    descendant.parent != nil,
                    "Descendents of the blocks should maintain their parent-child relationship."
                )
            }
        }
    }
}
