import Foundation
import RxSwift
import RxCocoa

final class SettingsConfigFetcher: SettingsConfigProtocol {
    private let defaultUrlString = "https://api.jsonserve.com/uVilvb"
    
     func getSettingsSections() -> Single<[SettingSection]> {
        
        guard let url = URL(string: defaultUrlString) else {
            return .error(SettingsError.couldNotFindUrl)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                try JSONDecoder().decode([SettingSection].self, from: data)
            }
            .catch({ error in
                if let urlError = error as? URLError {
                    return .error(SettingsError.networkError(urlError))
                } else {
                    return .error(SettingsError.uknownError)
                }
            })
            .asSingle()
    }
}
