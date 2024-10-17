import Markdown

@resultBuilder
public enum InlineMarkupBuilder {
    public static func buildExpression(
        _ expression: String
    ) -> [any InlineMarkup] {
        Document(parsing: expression)
            .children
            .flatMap(\.children)
            .compactMap { $0.detachedFromParent as? InlineMarkup }
    }

    public static func buildExpression(
        _ expression: some InlineMarkup
    ) -> [any InlineMarkup] {
        [expression]
    }

    public static func buildBlock(
        _ components: [any InlineMarkup]...
    ) -> [any InlineMarkup] {
        components.flatMap(\.self)
    }

    public static func buildOptional(
        _ component: [any InlineMarkup]?
    ) -> [any InlineMarkup] {
        component ?? []
    }

    public static func buildEither(
        first component: [any InlineMarkup]
    ) -> [any InlineMarkup] {
        return component
    }

    public static func buildEither(
        second component: [any InlineMarkup]
    ) -> [any InlineMarkup] {
        return component
    }

    public static func buildArray(
        _ components: [[any InlineMarkup]]
    ) -> [any InlineMarkup] {
        components.flatMap(\.self)
    }
}
