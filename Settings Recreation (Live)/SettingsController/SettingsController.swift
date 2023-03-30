import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SettingsController: UIViewController {
    
    let staticCellReuseIdentifier = "settingsCell"
    let switchCellIdentifier = "switchSettingsCell"
    let bag = DisposeBag()
    let viewModel: SettingsListViewModel
    
    init(viewModel: SettingsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainDataSource: RxTableViewSectionedReloadDataSource<SettingsSectionModel> =  {
        let dataSource = RxTableViewSectionedReloadDataSource<SettingsSectionModel>(configureCell: { [weak self] dataSource,tableView,indexPath, items in
            guard let self = self else { return UITableViewCell()}
            let data = dataSource[indexPath]
            let settingsCell: UITableViewCell
            
            switch items {
            case .staticSettingItem(let settingItem) :
                let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: self.staticCellReuseIdentifier) as? SettingsCell
                cell?.setCellAttributes(model: settingItem)
                settingsCell = cell ?? UITableViewCell()
                cell?.accessoryType = .disclosureIndicator
            case .switchSettingItem(item: let settingItem):
                let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: self.switchCellIdentifier) as? SwitchSettingsCell
                cell?.setCellAttributes(model: settingItem)
                settingsCell = cell ?? UITableViewCell()
            }
            return settingsCell
            
        }, titleForHeaderInSection: { dataSource, index in
            let section = dataSource[index]
            return section.title
            
        })
           return dataSource
    }()
 
    
    lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.registerTableView()
        self.bindTableView()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.configureTableView()
    }
    
    func configureTableView() {
        settingsTableView.backgroundColor = .systemBackground
        view.addSubview(settingsTableView)
        settingsTableView.fillToSuperView()
    }
    
    fileprivate func registerTableView() {
        view.addSubview(settingsTableView)
        settingsTableView.rx.setDelegate(self).disposed(by: bag)
        self.settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: staticCellReuseIdentifier)
        self.settingsTableView.register(SwitchSettingsCell.self, forCellReuseIdentifier: switchCellIdentifier)
    }
    
    fileprivate func bindTableView() {
        viewModel.sectionModels.drive(settingsTableView.rx.items(dataSource: mainDataSource)).disposed(by: bag)
        viewModel.sectionModels.drive(settingsTableView.rx.items) { (tableView: UITableView, index: Int, element: SettingsSectionModel) in
            
        }
    }

}

extension SettingsController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,titleForHeaderInSection section: Int) -> String? {
        return "default"
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = HeaderViewCell.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 90))
            return headerView
        }
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 100 : 20
    }

}

