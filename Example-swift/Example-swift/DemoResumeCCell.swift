//
//  DemoResumeCCell.swift
//  Example-swift
//
//  Created by rocky on 2020/9/7.
//  Copyright © 2020 Rocky. All rights reserved.
//

import UIKit

class DemoResumeCCell: UICollectionViewCell {
    
}

class ResumeImageCCell: UICollectionViewCell {
    
    let displayImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.displayImageView.backgroundColor = .decorateColor
        
        self.contentView.addSubview(self.displayImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayImageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ResumeBasicInfoCCell: UICollectionViewCell {
    
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.frame = CGRect(
            origin: CGPoint(x: 10, y: 4),
            size: CGSize(width: frame.width - 10, height: frame.height - 8)
        )
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        contentView.addSubview(stackView)
        
        //
        titleLabel.textColor = .titleColor
        titleLabel.text = "手机号"
        titleLabel.font = .systemFont(
            ofSize: 16,
            weight: .regular
        )
        stackView.addArrangedSubview(titleLabel)
        
        //
        detailLabel.textColor = .textColor
        detailLabel.text = "1538986381"
        detailLabel.font = .systemFont(
            ofSize: 15,
            weight: .light
        )
//        detailLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        titleLabel.setContentCompressionResistancePriority(.init(rawValue: 100), for: .vertical)
        
        stackView.addArrangedSubview(detailLabel)
        
//        titleLabel.setContentHuggingPriority(.init(249), for: .vertical)
//        detailLabel.setContentHuggingPriority(.init(252), for: .vertical)
//        
//        detailLabel.setContentCompressionResistancePriority(.init(253), for: .vertical)
        
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.backgroundColor = .decorateColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: [String: Any]) {
//        titleLabel.text = data["title"] as? String
//        detailLabel.text = data["detail"] as? String
    }
}

class ResumeSkillCCell: UICollectionViewCell {
    
    let contentLabel = UILabel()
    let dotView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        dotView.backgroundColor = .themeColor
        dotView.layer.cornerRadius = 4.0
        dotView.alpha = 0.5
        dotView.layer.masksToBounds = true
        
        contentLabel.textColor = .titleColor
        contentLabel.font = .systemFont(ofSize: 16, weight: .regular)
        contentLabel.numberOfLines = 0
        
        contentView.addSubview(dotView)
        contentView.addSubview(contentLabel)
        
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.backgroundColor = .decorateColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dotView.frame = CGRect(
            origin: .zero,
            size: CGSize(width: 8, height: 8)
        )
        dotView.center = CGPoint(
            x: 12,
            y: contentView.center.y
        )
        contentLabel.frame = CGRect(
            x: dotView.frame.maxX + 6,
            y: 4,
            width: contentView.frame.width - dotView.frame.maxX - 12,
            height: contentView.frame.height - 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: String) {
        contentLabel.text = data
    }
    
    static func skillCellHeight(with data: String) -> Float {
        let contentWidth = UIScreen.main.bounds.width - 18 - 8
        let innerData = NSString(string: data)
        let height = Float(innerData.boundingRect(
            with: CGSize(
                width: contentWidth,
                height: CGFloat.greatestFiniteMagnitude
            ),options: .usesLineFragmentOrigin,
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .regular)
            ],context: nil
        ).size.height) + 8
        
        return Float.maximum(50, height)
    }
}

class ResumeCompanyHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .decorateColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ResumeCompanyCCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.backgroundColor = .decorateColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data:[String: Any]) {
        
    }
}
