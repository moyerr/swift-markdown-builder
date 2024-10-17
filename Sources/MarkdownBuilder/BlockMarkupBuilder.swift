import Markdown

@resultBuilder
public enum BlockMarkupBuilder {
    public static func buildExpression(
        _ expression: String
    ) -> [any BlockMarkup] {
        Document(parsing: expression)
            .children
            .compactMap { $0.detachedFromParent as? BlockMarkup }
    }

    public static func buildExpression(
        _ expression: some InlineMarkup
    ) -> [any BlockMarkup] {
        [Paragraph(expression)]
    }

    public static func buildExpression(
        _ expression: some BlockMarkup
    ) -> [any BlockMarkup] {
        [expression]
    }

    public static func buildBlock(
        _ components: [any BlockMarkup]...
    ) -> [any BlockMarkup] {
        components.flatMap(\.self)
    }

    public static func buildOptional(
        _ component: [any BlockMarkup]?
    ) -> [any BlockMarkup] {
        component ?? []
    }

    public static func buildEither(
        first component: [any BlockMarkup]
    ) -> [any BlockMarkup] {
        return component
    }

    public static func buildEither(
        second component: [any BlockMarkup]
    ) -> [any BlockMarkup] {
        return component
    }

    public static func buildArray(
        _ components: [[any BlockMarkup]]
    ) -> [any BlockMarkup] {
        components.flatMap(\.self)
    }
}
