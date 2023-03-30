//
//  SettingsCell.swift
//  Settings Recreation (Live)
//
//  Created by Kingsley Charles on 22/05/2021.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image?.withTintColor(.white)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var iconView: UIView = {
        let iconView = UIView()
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 9
        return iconView
    }()
    
    lazy var iconTitle: UILabel = {
        let title = UILabel()
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate func addSubViews() {
        self.addSubview(iconView)
        iconView.addSubview(icon)
        self.addSubview(iconTitle)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: bottomAnchor, padding: UIEdgeInsets(top: 6, left: 14, bottom: 6, right: 0))
        
        icon.anchor(top: iconView.topAnchor, leading: iconView.leadingAnchor, trailing: iconView.trailingAnchor, bottom:iconView.bottomAnchor, padding: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        
        iconTitle.anchor(top: nil, leading: iconView.trailingAnchor, trailing: nil, bottom: nil, size: CGSize(width: 190, height: 40),padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        iconTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        icon.image = nil
        iconTitle.text = ""
        icon.backgroundColor = nil
    }
    
    func setCellAttributes(model: SettingItemViewModel) {
        let CIcolour = CIColor(color: model.iconBackgroundColor).stringRepresentation
        print("*****color is\(model.iconBackgroundColor), systemRepIS \(CIcolour.debugDescription)")
        icon.image = model.icon.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        iconTitle.text = model.title
        iconView.backgroundColor = model.iconBackgroundColor
    }

}
