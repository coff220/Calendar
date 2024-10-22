//
//  ViewController.swift
//  Calendar
//
//  Created by Viacheslav on 05/10/2024.
//

import UIKit


let calendar = Calendar.current
var dateComponents = DateComponents()

//let dateComponentsNow = calendar.dateComponents([.year,.month,.day], from: todayDate)
let dateFormatter = DateFormatter()

//var currentYear = dateComponentsN    ow.year






class ViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    var currentDate = Date()
    
    @IBAction func previousButtonAction(_ sender: Any) {
        currentDate = Date.previousMonth(before: currentDate)
        monthLabel.text = " \(currentDate.month) \(currentDate.year) "
        dateCollectionView.reloadData()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        currentDate = Date.nextMonth(after: currentDate)
        monthLabel.text = " \(currentDate.month) \(currentDate.year) "
        dateCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        configure()
    }
    
    func configure () {
        view.backgroundColor = .purple
        nextButton.layer.cornerRadius = nextButton.bounds.width / 2
        nextButton.backgroundColor = .systemOrange
        nextButton.setTitle(">", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 70) // ?
        
        previousButton.layer.cornerRadius = nextButton.bounds.width / 2
        previousButton.backgroundColor = .systemOrange
        previousButton.setTitle("<", for: .normal)
        previousButton.titleLabel?.font = UIFont.systemFont(ofSize: 70) // ?
        
        monthLabel.textColor = .orange
        monthLabel.text = " \(currentDate.month) \(currentDate.year) "
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentDate.lastDayOfMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.dayLabel.text = String(indexPath.row + 1)
        cell.backgroundColor = .cyan
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 8  , height: self.view.frame.width / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


extension Date {
    var lastDayOfMonth: Int {
        var components = Calendar.current.dateComponents([.month], from: self)
        var nextMonth = 0
        if let currentMounth = components.month {
            if currentMounth < 12 {
                nextMonth = currentMounth + 1
            } else {
                nextMonth = 1
            }
        }
        components.day = 1
        components.month = nextMonth
        let oneDayInterval = TimeInterval(60 * 60 * 24)
        let lastDeyOfThisMonth = Calendar.current.date(from: components)! - oneDayInterval
        let lastComponents = Calendar.current.dateComponents([.day], from: lastDeyOfThisMonth)
        return lastComponents.day ?? 0
    }
    
    var month: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM"
        return dateFormater.string(from: self)
    }
    
    var monthInt: Int {
        let components = Calendar.current.dateComponents([.month], from: self)
        return components.month ?? 0
    }
    
    var year: Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year ?? 0
    }
    
    static func nextMonth (after date: Date) -> Date {
        let nextMonth = Calendar.current.date(byAdding: .month, value: +1, to: date)
        return nextMonth ?? date
    }
    
    static func previousMonth (before date: Date) -> Date {
        let previosMonth = Calendar.current.date(byAdding: .month, value: -1, to: date)
        return previosMonth ?? date
    }
}

