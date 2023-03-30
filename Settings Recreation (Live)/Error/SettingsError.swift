import Foundation

enum SettingsError: Error {
    case couldNotFindUrl
    case networkError(Error)
    case uknownError
}
