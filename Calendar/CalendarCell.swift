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
        titleLabel = UILabel(frame: frame)
        titleLabel.contentMode = .center
        self.contentView.addSubview(titleLabel)
        
        self.layer.cornerRadius = 1.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.cyan.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
