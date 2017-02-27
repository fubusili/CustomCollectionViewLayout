//
//  HeaderView.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(frame: frame)
        titleLabel.contentMode = .center
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
