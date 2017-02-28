//
//  WeekLayout.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit
class WeekLayout: UICollectionViewLayout {
    
    static let daysPerWeek = 7
    static let hoursPerDay = 24
    static let horizontalSpacing = 10
    static let heightPerHour = 50
    static let dayHeaderHeight = 40
    static let hourHeaderWidth = 100
    
    //MARK: - Collection view layout implementation
    override var collectionViewContentSize: CGSize {
        let contenWith = self.collectionView?.bounds.size.width
        let contentHeight = CGFloat(WeekLayout.dayHeaderHeight + WeekLayout.heightPerHour * WeekLayout.hoursPerDay)
        let contenSize = CGSize(width: contenWith!, height: contentHeight)
        
        return contenSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        let visibleIndexPaths = self.indexPathsOfItems(inRect: rect)
        for indexPath in visibleIndexPaths {
            let attributes = self.layoutAttributesForItem(at: indexPath as IndexPath)
            layoutAttributes.append(attributes!)
            
        }
        
        let dayHeaderViewIndexPaths = self.indexPathsOfDayHeaderViews(inRect: rect)
        for indexPath in dayHeaderViewIndexPaths {
            let attributes = self.layoutAttributesForSupplementaryView(ofKind: "DayHeaderView", at: indexPath)
            layoutAttributes.append(attributes!)
        }
        
        let hourHeaderViewIndexPaths = self.indexPathsOfHourHeaderViews(inRect: rect)
        for indexPath in hourHeaderViewIndexPaths {
            let attributes = self.layoutAttributesForSupplementaryView(ofKind: "HourHeaderView", at: indexPath)
            layoutAttributes.append(attributes!)
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let dataSource = self.collectionView?.dataSource as! CalendarDataSource
        let event = dataSource.event(at:indexPath)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = self.frameForEvent(event: event)
        return attributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        let totalWidth = self.collectionViewContentSize.width
        if elementKind == "DayHeaderView" {
            let availabelWidth = totalWidth - CGFloat(WeekLayout.hourHeaderWidth)
            let widthPerDay = availabelWidth / CGFloat(WeekLayout.daysPerWeek)
            attributes.frame = CGRect(x: CGFloat(WeekLayout.hourHeaderWidth) + widthPerDay * CGFloat(indexPath.item), y: 0, width: widthPerDay, height: CGFloat(WeekLayout.dayHeaderHeight))
            attributes.zIndex = -10
        } else if elementKind == "HourHeaderView" {
            attributes.frame = CGRect(x: 0, y: CGFloat(WeekLayout.dayHeaderHeight) + CGFloat(WeekLayout.heightPerHour) * CGFloat(indexPath.item), width: totalWidth, height: CGFloat(WeekLayout.heightPerHour))
            attributes.zIndex = -10;
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //MARK: - Helpers
    func indexPathsOfItems(inRect rect: CGRect) -> [NSIndexPath] {
        let minVisibleDay = self.dayIndexFromXCoordinate(xPosition: rect.minX)
        let maxVisibleDay = self.dayIndexFromXCoordinate(xPosition: rect.maxX)
        let minVisibleHour = self.hourIndexFromYCoordinate(yPosition: rect.minY)
        let maxVisibleHour = self.hourIndexFromYCoordinate(yPosition: rect.maxY)
        
        let dataSource = self.collectionView?.dataSource as! CalendarDataSource
        let indexPaths = dataSource.indexPathsOfEvents(betweenMinDayIndex: minVisibleDay, maxDayIndex: maxVisibleDay, minStartHour: minVisibleHour, maxStartHour: maxVisibleHour)
        
        return indexPaths
        
    }
    
    func dayIndexFromXCoordinate(xPosition: CGFloat) -> Int {
        let contentWidth = self.collectionViewContentSize.width - CGFloat(WeekLayout.hourHeaderWidth)
        let widthPerDay = contentWidth / CGFloat(WeekLayout.daysPerWeek)
        let dayIndex = max(0, Int((xPosition - CGFloat(WeekLayout.hourHeaderWidth)) / widthPerDay))
        return dayIndex
    }
    
    func hourIndexFromYCoordinate(yPosition: CGFloat) -> Int {
        
        let hourIndex = max(0, Int((yPosition - CGFloat(WeekLayout.dayHeaderHeight)) /  CGFloat(WeekLayout.heightPerHour)))
        return hourIndex
    }
    
    func indexPathsOfDayHeaderViews(inRect rect: CGRect) -> [IndexPath] {
        if rect.minY > CGFloat(WeekLayout.dayHeaderHeight) {
            return []
        }
        
        var indexPaths = [IndexPath]()
        
        let minDayIndex = self.dayIndexFromXCoordinate(xPosition: rect.minX)
        let maxDayIndex = self.dayIndexFromXCoordinate(xPosition: rect.maxX)

        for idx in minDayIndex ... maxDayIndex {
            indexPaths.append(IndexPath(item: idx, section: 0))
        }
        return indexPaths
    }
    
    func indexPathsOfHourHeaderViews(inRect rect: CGRect) -> [IndexPath] {
        if rect.minX > CGFloat(WeekLayout.hourHeaderWidth) {
            return []
        }
        
        var indexPaths = [IndexPath]()
        
        let minHourIndex = self.hourIndexFromYCoordinate(yPosition: rect.minY)
        let maxHourIndex = self.hourIndexFromYCoordinate(yPosition: rect.maxY)
        
        for idx in minHourIndex ... maxHourIndex {
            indexPaths.append(IndexPath(item: idx, section: 0))
        }
        return indexPaths
    }
    
    func frameForEvent(event: CalendarEvent) -> CGRect {
        let totalWidth = self.collectionViewContentSize.width - CGFloat(WeekLayout.hourHeaderWidth)
        let widthPerDay = totalWidth / CGFloat(WeekLayout.daysPerWeek)
        
        var frame = CGRect()
        frame.origin.x = CGFloat(WeekLayout.hourHeaderWidth) + widthPerDay * CGFloat(event.day!)
        frame.origin.y = CGFloat(WeekLayout.dayHeaderHeight) + CGFloat(WeekLayout.heightPerHour * event.startHour!)
        frame.size.width = widthPerDay
        frame.size.height = CGFloat(event.durationInHours!) * CGFloat(WeekLayout.heightPerHour)
        frame = frame.insetBy(dx: CGFloat(WeekLayout.horizontalSpacing / 2), dy: 0)
        return frame
    }
    
}
