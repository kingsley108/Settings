import Foundation
import UIKit

struct SettingItemViewModel {
    let title: String
    let icon: UIImage
    let iconBackgroundColor: UIColor
    let cellType: SettingsCellType
    
    init(title: String, icon: UIImage, iconBackgroundColor: UIColor, cellType: SettingsCellType) {
        self.title = title
        self.icon = icon
        self.iconBackgroundColor = iconBackgroundColor
        self.cellType = cellType
    }
    
    static private func convertSettingDetailToItem(from itemDetail: SettingDetail) -> SettingItemViewModel {
        let defaultImage = UIImage(systemName: "gear.badge.questionmark")!
        let image = UIImage(systemName: itemDetail.iconName) ?? defaultImage
        let iconBackground = UIColor(ciColor: CIColor(string: itemDetail.color))
        let title = itemDetail.settingTitle
        let cellType = SettingsCellType(rawValue: itemDetail.type) ?? .staticCell
        return SettingItemViewModel(title: title, icon: image, iconBackgroundColor: iconBackground, cellType: cellType)
    }
    
    static func sectionModelConverter(from section: SettingsContent) -> SettingItemViewModel {
        return convertSettingDetailToItem(from: section.attributes)
    }
    
    static func getItems(from section: SettingSection) -> SettingsSectionModel {
        return convertToSettingSectionModel(fromSection: section)
    }
    
    static func convertToSettingSectionModel(fromSection section: SettingSection) -> SettingsSectionModel {
        let title = section.title
        let sectionType = SettingsSectionType(rawValue: title) ?? .general
        let itemViewModels = section.sections.map { self.sectionModelConverter(from: $0) }
        
        let sectionItem = itemViewModels.map { $0.cellType.getSectionItem(using: $0)}
        let sectionData = SectionData(item: sectionItem, title: title)
        return sectionType.getSectionModel(using: sectionData)
    }
    
}
