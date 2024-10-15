import Markdown

@resultBuilder
enum InlineMarkupBuilder {
    static func buildExpression(
        _ expression: String
    ) -> [any InlineMarkup] {
        Document(parsing: expression)
            .children
            .flatMap(\.children)
            .compactMap { $0.detachedFromParent as? InlineMarkup }
    }

    static func buildExpression(
        _ expression: some InlineMarkup
    ) -> [any InlineMarkup] {
        [expression]
    }

    static func buildBlock(
        _ components: [any InlineMarkup]...
    ) -> [any InlineMarkup] {
        components.flatMap(\.self)
    }

    static func buildOptional(
        _ component: [any InlineMarkup]?
    ) -> [any InlineMarkup] {
        component ?? []
    }

    static func buildEither(
        first component: [any InlineMarkup]
    ) -> [any InlineMarkup] {
        return component
    }

    static func buildEither(
        second component: [any InlineMarkup]
    ) -> [any InlineMarkup] {
        return component
    }

    static func buildArray(
        _ components: [[any InlineMarkup]]
    ) -> [any InlineMarkup] {
        components.flatMap(\.self)
    }
}
