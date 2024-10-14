@_exported import Markdown

// MARK: - Protocol Extensions

extension BasicBlockContainer {
    public init(
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(content())
    }

    public init(
        inheritSourceRange: Bool,
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(content())
    }
}

extension BasicInlineContainer {
    public init(
        @InlineMarkupBuilder content: () -> [any InlineMarkup]
    ) {
        self.init(content())
    }

    public init(
        inheritSourceRange: Bool,
        @InlineMarkupBuilder _ content: () -> [any InlineMarkup]
    ) {
        self.init(content())
    }
}

extension ListItemContainer {
    public init(
        @ListItemBuilder _ content: () -> [ListItem]
    ) {
        self.init(content())
    }
}

// MARK: Explicit Blocks

extension CodeBlock {
    public init(
        language: String? = nil,
        _ content: () -> String
    ) {
        self.init(language: language, content())
    }
}

extension HTMLBlock {
    public init(_ content: () -> String) {
        self.init(content())
    }
}

// MARK: - Inline Containers

extension Heading {
    public init(
        level: Int,
        @InlineMarkupBuilder _ content: () -> [any InlineMarkup]
    ) {
        self.init(level: level, content())
    }
}

extension Image {
    public init(
        source: String? = nil,
        title: String? = nil,
        @RecurringInlineMarkupBuilder _ content: () -> [any RecurringInlineMarkup]
    ) {
        self.init(source: source, title: title, content())
    }
}

extension InlineAttributes {
    public init(
        attributes: String,
        @RecurringInlineMarkupBuilder _ content: () -> [any RecurringInlineMarkup]
    ) {
        self.init(attributes: attributes, content())
    }
}

extension Link {
    public init(
        destination: String? = nil,
        title: String? = nil,
        @RecurringInlineMarkupBuilder _ content: () -> [any RecurringInlineMarkup]
    ) {
        self.init(destination: destination, title: title, content())
    }
}

// MARK: - Block Containers

extension BlockDirective {
    public init(
        name: String,
        argumentText: String? = nil,
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(name: name, argumentText: argumentText, children: content())
    }
}

extension DoxygenDiscussion {
    public init(
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(children: content())
    }
}

extension DoxygenNote {
    public init(
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(children: content())
    }
}

extension DoxygenParameter {
    public init(
        name: String,
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(name: name, children: content())
    }
}

extension DoxygenReturns {
    public init(
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(children: content())
    }
}

extension ListItem {
    public init(
        checkbox: Checkbox? = nil,
        @BlockMarkupBuilder _ content: () -> [any BlockMarkup]
    ) {
        self.init(checkbox: checkbox, content())
    }
}
