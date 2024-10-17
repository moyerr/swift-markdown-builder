import Markdown

@resultBuilder
public enum RecurringInlineMarkupBuilder {
    public static func buildExpression(
        _ expression: String
    ) -> [any RecurringInlineMarkup] {
        Document(parsing: expression)
            .children
            .flatMap(\.children)
            .compactMap { $0.detachedFromParent as? RecurringInlineMarkup }
    }

    public static func buildExpression(
        _ expression: some RecurringInlineMarkup
    ) -> [any RecurringInlineMarkup] {
        [expression]
    }

    public static func buildBlock(
        _ components: [any RecurringInlineMarkup]...
    ) -> [any RecurringInlineMarkup] {
        components.flatMap(\.self)
    }

    public static func buildOptional(
        _ component: [any RecurringInlineMarkup]?
    ) -> [any RecurringInlineMarkup] {
        component ?? []
    }

    public static func buildEither(
        first component: [any RecurringInlineMarkup]
    ) -> [any RecurringInlineMarkup] {
        return component
    }

    public static func buildEither(
        second component: [any RecurringInlineMarkup]
    ) -> [any RecurringInlineMarkup] {
        return component
    }

    public static func buildArray(
        _ components: [[any RecurringInlineMarkup]]
    ) -> [any RecurringInlineMarkup] {
        components.flatMap(\.self)
    }
}
