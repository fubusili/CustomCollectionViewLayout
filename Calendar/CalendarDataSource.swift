//
//  CalendarDataSource.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit

class CalendarDataSource:NSObject, UICollectionViewDataSource {
    
    
    var events:[CalendarEvent]?
    
    typealias configureCellBlock = (_ cell: CalendarCell, _ indexPath: NSIndexPath, _ event: CalendarEvent) -> Void
    
    typealias configureHeaderViewBlock = (_ headerView: HeaderView, _ kind: String, _ indexPath: NSIndexPath) -> Void
    
    var configureCell:configureCellBlock?
    
    
    override func awakeFromNib() {
        self.generateSampleData()
    }
    
    func generateSampleData() {
        
        self.events? = Array(repeating: CalendarModel.randomEvent(), count: 20)
        
    }
    
    //MARK: - CalendarDataSource
    func eventAtIndexPath(indexPath: NSIndexPath) -> CalendarEvent {
        return self.events![indexPath.item]
    }
    
    func indexPathsOfEvents(betweenMinDayIndex minDayIndex: Int, maxDayIndex: Int, minStartHour: Int, maxStartHour: Int) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        for (index, event) in (self.events?.enumerated())! {
            if event.day! >= minDayIndex && event.day! <= maxDayIndex && event.startHour! >= minStartHour && event.startHour! <= maxDayIndex {
                indexPaths.append(NSIndexPath(item: index, section: 0))
            }
            
        }
        return indexPaths
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.events?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event = self.events?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        if (self.configureCell != nil) {
            self.configureCell!(cell, indexPath as NSIndexPath, event!)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderView", for: indexPath)
        return headerView
    }
    
//    func configureCellHandler(cellBlock: @escaping configureCellBlock) {
//        self.configureCell = cellBlock
//    }
    
}
