import Markdown

@resultBuilder
public enum ListItemBuilder {
    public static func buildExpression(
        _ expression: ListItem
    ) -> [ListItem] {
        [expression]
    }

    public static func buildBlock(
        _ components: [ListItem]...
    ) -> [ListItem] {
        components.flatMap(\.self)
    }

    public static func buildOptional(
        _ component: [ListItem]?
    ) -> [ListItem] {
        component ?? []
    }

    public static func buildEither(
        first component: [ListItem]
    ) -> [ListItem] {
        return component
    }

    public static func buildEither(
        second component: [ListItem]
    ) -> [ListItem] {
        return component
    }

    public static func buildArray(
        _ components: [[ListItem]]
    ) -> [ListItem] {
        components.flatMap(\.self)
    }
}
