import Markdown

@resultBuilder
enum ListItemBuilder {
    static func buildExpression(
        _ expression: ListItem
    ) -> [ListItem] {
        [expression]
    }

    static func buildBlock(
        _ components: [ListItem]...
    ) -> [ListItem] {
        components.flatMap { $0 }
    }

    static func buildOptional(
        _ component: [ListItem]?
    ) -> [ListItem] {
        component ?? []
    }

    static func buildEither(
        first component: [ListItem]
    ) -> [ListItem] {
        return component
    }

    static func buildEither(
        second component: [ListItem]
    ) -> [ListItem] {
        return component
    }

    static func buildArray(
        _ components: [[ListItem]]
    ) -> [ListItem] {
        components.flatMap { $0 }
    }
}
