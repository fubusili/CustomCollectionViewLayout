//
//  HeaderView.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {

    var titleLabel: UILabel!
    var separatorLine: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel = UILabel(frame: CGRect(origin: CGPoint(), size: frame.size))
        self.addSubview(self.titleLabel)
        
        self.separatorLine = UIView(frame: CGRect(origin: CGPoint(x: 0, y: self.frame.size.height - 0.5), size: CGSize(width: self.frame.size.width, height: 0.5)))
        self.separatorLine.backgroundColor = .lightGray
        self.addSubview(self.separatorLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
