import Foundation
import RxSwift

protocol SettingsConfigProtocol {
    func getSettingsSections() -> Single<[SettingSection]>
}
