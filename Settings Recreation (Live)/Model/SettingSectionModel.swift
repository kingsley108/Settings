import Foundation
import RxDataSources

extension SettingsSectionModel: SectionModelType {
    init(original: SettingsSectionModel, items: [SettingSectionItem]) {
        switch original {
        case .generalSection(let title, _):
            self = .generalSection(title: title, item: items)
        case .connectivitySection(title: let title, item: _):
            self = .generalSection(title: title, item: items)
        case .notificationsSection(title: let title, item: _):
            self = .generalSection(title: title, item: items)
        }
    }
    
    typealias Item = SettingSectionItem
    
    var items: [SettingSectionItem] {
        switch self {
        case .generalSection(title: _, item: let items):
            return items
        case .connectivitySection(title: _, item: let items):
            return items
        case .notificationsSection(title: _, item: let items):
            return items
        }
    }
    
    var title: String {
        switch self {
        case .generalSection(let title, _):
            return title
        case .connectivitySection(title: let title, item: _):
            return title
        case .notificationsSection(title: let title, item: _):
            return title
        }
    }
    
}
