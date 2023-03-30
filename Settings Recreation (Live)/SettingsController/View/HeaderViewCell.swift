//
//  HeaderCell.swift
//  Settings Recreation (Live)
//
//  Created by Kingsley Charles on 22/05/2021.
//

import Foundation
import UIKit

class HeaderViewCell: UIView {
    
    lazy var userFieldIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.image?.withTintColor(.systemGray)
        imageView.image = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.systemGray).withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    
    lazy var userName: UILabel = {
        let title = UILabel()
        title.text = "Kingsley Charles"
        title.font = UIFont.systemFont(ofSize: 20)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addSubViews() {
        self.addSubview(userFieldIcon)
        self.addSubview(userName)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        userFieldIcon.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: bottomAnchor, padding: UIEdgeInsets(top: 4, left: 44, bottom: 4, right: 0))
        userName.anchor(top: nil, leading: userFieldIcon.trailingAnchor, trailing: nil, bottom: nil,size: CGSize(width: 200, height: 44),padding: UIEdgeInsets(top: 0,left: 40 , bottom: 0, right: 0))
        userName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }
}

