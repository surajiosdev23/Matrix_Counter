//
//  ViewController.swift
//  Matrix Counter
//
//  Created by suraj jadhav on 12/02/24.
//

import UIKit
import SpreadsheetView

class ViewController: UIViewController {
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    
    private let viewModel = SpreadsheetViewModel()
//    private var dayDataArray = [DayData]()
//    private var dayArray = [Int]()
//    private var dayRecordModel: DayRecordModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpreadsheetView()
        viewModel.delegate = self
        viewModel.fetchDataFromJSON()
    }
    
    private func setupSpreadsheetView() {
        // Setup your SpreadsheetView instance here
        spreadsheetView.dataSource = self
        spreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadsheetView.intercellSpacing = CGSize(width: 5, height: 5)
        spreadsheetView.gridStyle = .none
    }
}

extension ViewController: SpreadsheetViewDataSource {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
        
        let row = indexPath.section - 1
        let column = indexPath.item - 1
        
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                cell.label.text = "hour"
            } else {
                let day = viewModel.dayArray[column]
                let date = dayWithOrdinalSuffix(for: day)
                cell.label.text = "\(day)" + date
            }
            cell.backgroundColor = .clear
        } else {
            if indexPath.item == 0 {
                cell.label.text = (indexPath.section - 1) % 2 == 0 ? "\(indexPath.section - 1)" : ""
                cell.backgroundColor = .clear
            } else {
                configureDataCell(cell, forRowAt: row, andColumnAt: column)
            }
        }
        return cell
    }

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 25
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 17
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 40
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }

    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    // Helper Methods
    private func configureDataCell(_ cell: HeaderCell, forRowAt row: Int, andColumnAt column: Int) {
        var recordCount = "0"
        var backgroundColor: UIColor = .lightGray
        
        let count = viewModel.dayRecordModel?[column].hours?.count ?? 0
        if count < 24 {
            if row < 24 - count {
                recordCount = "0"
            } else {
                recordCount = "\(viewModel.dayRecordModel?[column].hours?[23 - row].recordCount ?? 0)"
            }
        } else {
            recordCount = "\(viewModel.dayRecordModel?[column].hours?[row].recordCount ?? 0)"
        }
        if recordCount == "0"{
            backgroundColor = .lightGray
        }else{
            let opacity = (Double(recordCount) ?? 0.0) / 1000.0
            backgroundColor = UIColor(red: 18.0/255.0, green: 92.0/255.0, blue: 33.0/255.0, alpha: CGFloat(opacity))
        }
        cell.label.text = ""
        cell.backgroundColor = backgroundColor
    }

    private func dayWithOrdinalSuffix(for day: Int) -> String {
        switch day {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
}

extension ViewController: SpreadsheetViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.spreadsheetView.reloadData()
        }
    }

    func showError(message: String) {
        print("Error: \(message)")
        // Handle error display
    }
}

