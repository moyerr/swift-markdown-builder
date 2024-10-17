import Testing
@testable import MarkdownBuilder

@Suite("Recurring inline markup builder tests")
struct RecurringInlineMarkupBuilderTests {

    @Test("Build from a single raw string expression")
    func testSingleRawStringExpression() {
        let result = Strong {
            "Line has `some code` and _some emphasis_"
        }

        let expected = """
            Strong
            ├─ Text "Line has "
            ├─ InlineCode `some code`
            ├─ Text " and "
            └─ Emphasis
               └─ Text "some emphasis"
            """

        #expect(result.debugDescription() == expected)
    }

    @Test("Build from multiple raw string expressions")
    func testMultipleRawStringExpressions() {
        let result = Strong {
            "Line has `some code` and"
            "_some emphasis_"
        }

        let expected = """
            Strong
            ├─ Text "Line has "
            ├─ InlineCode `some code`
            ├─ Text " and"
            └─ Emphasis
               └─ Text "some emphasis"
            """

        #expect(result.debugDescription() == expected)
    }

    @Test("Build from a single recurring inline markup expression")
    func testSingleRecurringInlineMarkupExpression() {
        let result = Strong {
            Text("Some text")
        }

        let expected = """
            Strong
            └─ Text "Some text"
            """

        #expect(result.debugDescription() == expected)
    }

    @Test("Build from multiple recurring inline markup expressions")
    func testMultipleRecurringInlineMarkupExpressions() {
        let result = Strong {
            InlineCode("some code")
            Text(" and ")
            Emphasis(Text("some emphasis"))
        }

        let expected = """
            Strong
            ├─ InlineCode `some code`
            ├─ Text " and "
            └─ Emphasis
               └─ Text "some emphasis"
            """

        #expect(result.debugDescription() == expected)
    }

    @Test("Build recurring inline markup with simple if block", arguments: [true, false])
    func testIfBlock(_ showCode: Bool) {
        let result = Strong {
            if showCode {
                InlineCode("some code")
                Text(" and ")
            }

            Emphasis(Text("some emphasis"))
        }

        let expected = showCode ? """
            Strong
            ├─ InlineCode `some code`
            ├─ Text " and "
            └─ Emphasis
               └─ Text "some emphasis"
            """ : """
            Strong
            └─ Emphasis
               └─ Text "some emphasis"
            """

        #expect(result.debugDescription() == expected)
    }

    @Test("Build recurring inline markup with if/else blocks", arguments: [true, false])
    func testIfElseBlock(_ showCode: Bool) {
        let result = Strong {
            if showCode {
                InlineCode("some code")
            } else {
                Emphasis(Text("some emphasis"))
            }
        }

        let expected = showCode ? """
            Strong
            └─ InlineCode `some code`
            """ : """
            Strong
            └─ Emphasis
               └─ Text "some emphasis"
            """

        #expect(result.debugDescription() == expected)
    }

    @Test("Build recurring inline markup using a for-loop")
    func testForLoops() {
        let result = Strong {
            for i in 1...4 {
                Emphasis(Text("\(i)"))
                Text(" and ")
            }
        }

        let expected = """
            Strong
            ├─ Emphasis
            │  └─ Text "1"
            ├─ Text " and "
            ├─ Emphasis
            │  └─ Text "2"
            ├─ Text " and "
            ├─ Emphasis
            │  └─ Text "3"
            ├─ Text " and "
            ├─ Emphasis
            │  └─ Text "4"
            └─ Text " and "
            """

        #expect(result.debugDescription() == expected)
    }

    @Test(
        "Ensure recurring inline elements built from raw strings have no parent",
        Comment("""
            Elements built from raw strings are parsed using the the Document(parsing:) \
            initializer. The individual items returned by the result builder should \
            not reference that Document as their parent.
            """
        )
    )
    func testRawStringsProduceElementsWithoutParents() {
        @RecurringInlineMarkupBuilder
        var results: [any RecurringInlineMarkup] {
            """
            First line has **strong text**
            Second line has `some code`
            """
        }

        #expect(results.count == 5)

        for child in results {
            #expect(child.parent == nil, "Recurring inline elements returned by the builder should have no parent")

            for descendant in child.children {
                #expect(
                    descendant.parent != nil,
                    "Descendents of the recurring inline elements should maintain their parent-child relationship."
                )
            }
        }
    }

}
