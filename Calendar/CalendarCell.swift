//
//  CalendarCell.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit
class CalendarCell: UICollectionViewCell {
    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel = UILabel()
        self.titleLabel.contentMode = .center
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.font = UIFont.systemFont(ofSize: 12.0)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textColor = .orange
        
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = CGRect(origin: CGPoint(), size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
