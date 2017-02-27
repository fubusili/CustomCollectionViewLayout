//
//  CalendarDataSource.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit

class CalendarDataSource {
    
    
    var events:[CalendarModel]?
    
    
    func generateSampleData() {
        
    }
    
    //MARK: -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
        
    }
    
}
