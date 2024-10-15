import Markdown

@resultBuilder
enum BlockMarkupBuilder {
    static func buildExpression(
        _ expression: String
    ) -> [any BlockMarkup] {
        Document(parsing: expression)
            .children
            .compactMap { $0.detachedFromParent as? BlockMarkup }
    }

    static func buildExpression(
        _ expression: some InlineMarkup
    ) -> [any BlockMarkup] {
        [Paragraph(expression)]
    }

    static func buildExpression(
        _ expression: some BlockMarkup
    ) -> [any BlockMarkup] {
        [expression]
    }

    static func buildBlock(
        _ components: [any BlockMarkup]...
    ) -> [any BlockMarkup] {
        components.flatMap(\.self)
    }

    static func buildOptional(
        _ component: [any BlockMarkup]?
    ) -> [any BlockMarkup] {
        component ?? []
    }

    static func buildEither(
        first component: [any BlockMarkup]
    ) -> [any BlockMarkup] {
        return component
    }

    static func buildEither(
        second component: [any BlockMarkup]
    ) -> [any BlockMarkup] {
        return component
    }

    static func buildArray(
        _ components: [[any BlockMarkup]]
    ) -> [any BlockMarkup] {
        components.flatMap(\.self)
    }
}
