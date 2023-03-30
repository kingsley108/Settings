import Foundation
import RxSwift
import RxCocoa

final class SettingsListViewModel {
    private let configService: SettingsConfigProtocol
    var sectionModels: Driver<[SettingsSectionModel]> {
            return getSettingsItemModel()
    }
    
    init(settingsConfigService: SettingsConfigProtocol = SettingsConfigFetcher()) {
        self.configService = settingsConfigService
    }
    
   
    private func getSettingsItemModel() -> Driver<[SettingsSectionModel]> {
        return configService.getSettingsSections().map { sections -> [SettingsSectionModel] in
            sections.map { SettingItemViewModel.convertToSettingSectionModel(fromSection: $0) }
        }.asDriver(onErrorJustReturn: [])
    }
}
