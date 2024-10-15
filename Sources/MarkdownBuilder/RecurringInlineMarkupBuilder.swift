import Markdown

@resultBuilder
enum RecurringInlineMarkupBuilder {
    static func buildExpression(
        _ expression: String
    ) -> [any RecurringInlineMarkup] {
        Document(parsing: expression)
            .children
            .flatMap(\.children)
            .compactMap { $0 as? RecurringInlineMarkup }
    }

    static func buildExpression(
        _ expression: some RecurringInlineMarkup
    ) -> [any RecurringInlineMarkup] {
        [expression]
    }

    static func buildBlock(
        _ components: [any RecurringInlineMarkup]...
    ) -> [any RecurringInlineMarkup] {
        components.flatMap { $0 }
    }

    static func buildOptional(
        _ component: [any RecurringInlineMarkup]?
    ) -> [any RecurringInlineMarkup] {
        component ?? []
    }

    static func buildEither(
        first component: [any RecurringInlineMarkup]
    ) -> [any RecurringInlineMarkup] {
        return component
    }

    static func buildEither(
        second component: [any RecurringInlineMarkup]
    ) -> [any RecurringInlineMarkup] {
        return component
    }

    static func buildArray(
        _ components: [[any RecurringInlineMarkup]]
    ) -> [any RecurringInlineMarkup] {
        components.flatMap { $0 }
    }
}
