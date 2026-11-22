import Foundation
import Testing

/// 外观页 iOS 布局守卫。
///
/// iOS 不再复用桌面 scaffold 与色块列表行，而是使用系统 `Form`：
/// 「当前主题」+「主题」两个分组、带主题图标的可选择行，
/// 以及同样基于 `Form` 的原生预览弹层。
@Suite("外观页 iOS 布局")
struct ThemeSettingsIOSLayoutTests {
    private static var packageRoot: URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()   // LumiThemePackTests
            .deletingLastPathComponent()   // Tests
            .deletingLastPathComponent()   // <pkg>
    }

    private static func detailView() throws -> String {
        let url = Self.packageRoot
            .appendingPathComponent("Sources/LumiThemePack/ThemeSettingsDetailView.swift")
        return try String(contentsOf: url, encoding: .utf8)
    }

    @Test("iOS 使用系统 Form 分组")
    func usesNativeForm() throws {
        let view = try Self.detailView()
        #expect(view.contains("#if os(iOS)"))
        #expect(view.contains("private var iosBody"))
        #expect(view.contains("Form {\n            if let currentTheme"))
        #expect(view.contains("Current Theme"))
        #expect(view.contains("} footer: {"))
    }

    @Test("主题行使用图标、对勾与可访问性状态")
    func usesNativeThemeRows() throws {
        let view = try Self.detailView()
        #expect(view.contains("Image(systemName: item.iconName)"))
        #expect(view.contains("juicenote.setting.appearance.theme."))
        #expect(view.contains(".accessibilityAddTraits(isActive ? [.isSelected] : [])"))
        #expect(!view.contains("AppSettingCheckmarkRow("))
    }

    @Test("预览弹层使用 Form 与主题色板样板")
    func previewUsesNativeForm() throws {
        let view = try Self.detailView()
        #expect(view.components(separatedBy: "Form {").count == 3)
        #expect(view.contains("juicenote.setting.appearance.preview"))
        #expect(view.contains("Currently Using"))
        #expect(view.contains("Theme Colors"))
        #expect(view.contains("colorSwatch("))
    }
}