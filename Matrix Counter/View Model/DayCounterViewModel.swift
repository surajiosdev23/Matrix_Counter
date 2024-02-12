//
//  DayCounterViewModel.swift
//  Matrix Counter
//
//  Created by suraj jadhav on 12/02/24.
//

import Foundation
protocol SpreadsheetViewModelDelegate: AnyObject {
    func reloadData()
    func showError(message: String)
}

class SpreadsheetViewModel {
    weak var delegate: SpreadsheetViewModelDelegate?
    var dayDataArray = [DayData]()
    var dayArray = [Int]()
    var dayRecordModel: DayRecordModel?

    func fetchDataFromJSON() {
        guard let path = Bundle.main.path(forResource: "hours_record", ofType: "json") else {
            delegate?.showError(message: "JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            dayRecordModel = try JSONDecoder().decode(DayRecordModel.self, from: data)
            dayDataArray = try JSONDecoder().decode([DayData].self, from: data)
            setDayColumn(dayDataArray)
            delegate?.reloadData()
        } catch {
            delegate?.showError(message: "Error reading JSON file: \(error.localizedDescription)")
        }
    }

    private func setDayColumn(_ dayDataArray: [DayData]) {
        dayArray = dayDataArray.compactMap { Int($0.day.prefix(8).suffix(2)) }
    }
}
