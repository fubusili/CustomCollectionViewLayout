//
//  CalendarViewController.swift
//  Calendar
//
//  Created by hc_cyril on 2017/2/27.
//  Copyright © 2017年 Clark. All rights reserved.
//

import UIKit

private let calendarCellIdentifier = "CalendarCell"
private let supplementaryViewIdentifier = "HeaderView"
private let supplementaryDayHeaderViewIdentifier = "DayHeaderView"
private let supplementaryHourHeaderViewIdentifier = "HourHeaderView"

class CalendarViewController: UICollectionViewController {

    var dataSource: CalendarDataSource?
    var headerView: HeaderView!
    var events = [CalendarEvent]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.collectionView?.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(CalendarCell.self, forCellWithReuseIdentifier: calendarCellIdentifier)
        self.collectionView!.register(HeaderView.self, forSupplementaryViewOfKind: supplementaryDayHeaderViewIdentifier, withReuseIdentifier: supplementaryViewIdentifier)
        self.collectionView!.register(HeaderView.self, forSupplementaryViewOfKind: supplementaryHourHeaderViewIdentifier, withReuseIdentifier: supplementaryViewIdentifier)

        // Do any additional setup after loading the view.
        for _ in 0 ..< 20 {
            self.events.append(CalendarModel.randomEvent())
        }
        self.dataSource = CalendarDataSource(events: self.events, cellIdentifier: calendarCellIdentifier, supplementaryIdentifier: supplementaryViewIdentifier, configureCellBlock: { (cell, indexPath, event) in
            
            cell.titleLabel.text = event.title
            print("cell.titleLabel.text = \(event.title)")
            
        }, configureHeaderViewBlock: { (headerView, kind, indexPath) in
            if kind == supplementaryDayHeaderViewIdentifier {
                headerView.titleLabel.text = "Day \(indexPath.item + 1)"
            } else if kind == supplementaryHourHeaderViewIdentifier {
                headerView.titleLabel.text = "\(indexPath.item + 1):00"
            }
        })
        self.collectionView?.dataSource = self.dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

}
