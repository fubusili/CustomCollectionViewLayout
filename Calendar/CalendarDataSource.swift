//
//  CalendarDataSource.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit

class CalendarDataSource:NSObject, UICollectionViewDataSource {
    
    typealias ConfigureCellBlock = (_ cell: CalendarCell, _ indexPath: NSIndexPath, _ event: CalendarEvent) -> Void
    
    typealias ConfigureHeaderViewBlock = (_ headerView: HeaderView, _ kind: String, _ indexPath: IndexPath) -> Void
    
    var configureCellBlock: ConfigureCellBlock?
    var configureHeaderViewBlock: ConfigureHeaderViewBlock?
    var events:[CalendarEvent]?
    var cellIdentifier: String?
    var supplementaryIdentifier: String?
    
    //MARK: - Init
    init(events: [CalendarEvent]?, cellIdentifier: String?, supplementaryIdentifier: String?, configureCellBlock: @escaping ConfigureCellBlock, configureHeaderViewBlock
        :@escaping ConfigureHeaderViewBlock) {
        super.init()
        self.cellIdentifier = cellIdentifier
        self.supplementaryIdentifier = supplementaryIdentifier
        self.events = events
        self.configureCellBlock = configureCellBlock
        self.configureHeaderViewBlock = configureHeaderViewBlock
        
    }
    
    //MARK: - CalendarDataSource
    func event(at indexPath: IndexPath) -> CalendarEvent {
        return self.events![indexPath.item]
    }
    
    func indexPathsOfEvents(betweenMinDayIndex minDayIndex: Int, maxDayIndex: Int, minStartHour: Int, maxStartHour: Int) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        for (index, event) in (self.events?.enumerated())! {
            if event.day! >= minDayIndex && event.day! <= maxDayIndex && event.startHour! >= minStartHour && event.startHour! <= maxStartHour {
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
        let event = self.event(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier!, for: indexPath) as! CalendarCell
        if self.configureCellBlock != nil {
            self.configureCellBlock!(cell, indexPath as NSIndexPath, event)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.supplementaryIdentifier!, for: indexPath) as! HeaderView
        if configureHeaderViewBlock != nil {
            configureHeaderViewBlock!(headerView, kind, indexPath)
        }
        return headerView
    }
    
}
