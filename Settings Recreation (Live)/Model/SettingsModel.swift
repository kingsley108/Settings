import Foundation
typealias SectionData = (item: [SettingSectionItem], title: String)

struct SettingSection: Codable {
    let title: String
    let sections: [SettingsContent]
}

struct SettingsContent: Codable {
    var attributes: SettingDetail
}

struct SettingDetail: Codable {
    var type: String
    var settingTitle: String
    var iconName: String
    var color: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case settingTitle
        case iconName
        case color
    }
}

enum SettingsCellType: String {
    case switchCell = "switchCell"
    case staticCell = "staticCell"
    
    func getSectionItem(using item: SettingItemViewModel) -> SettingSectionItem {
        switch self {
        case .switchCell:
            return .switchSettingItem(item: item)
        case .staticCell:
            return .staticSettingItem(item: item)
        }
    }
}

enum SettingsSectionType: String {
    case connectivity = "Connectivity"
    case notification = "Notification"
    case general = "General"
    
    func getSectionModel(using data: SectionData) -> SettingsSectionModel {
        switch self {
        case .connectivity:
            return SettingsSectionModel(original: .connectivitySection(title: data.title, item: data.item), items: data.item)
        case .notification:
            return SettingsSectionModel(original: .notificationsSection(title: data.title, item: data.item), items: data.item)
        case .general:
            return SettingsSectionModel(original: .generalSection(title: data.title, item: data.item), items: data.item)
        }
    }
}


enum SettingSectionItem {
    case switchSettingItem(item: SettingItemViewModel)
    case staticSettingItem(item: SettingItemViewModel)
}

enum SettingsSectionModel {
    case connectivitySection(title: String, item: [SettingSectionItem])
    case notificationsSection(title: String, item: [SettingSectionItem])
    case generalSection(title: String, item: [SettingSectionItem])
}
