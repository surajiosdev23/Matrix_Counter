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
            if let path = Bundle.main.path(forResource: "hours_record", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    var dayDataArray = try JSONDecoder().decode(DayRecordModel.self, from: data)
                    
                    // Iterate over each day's data
                    for index in 0..<dayDataArray.count {
                        let dayData = dayDataArray[index]
                        
                        // Create a dictionary for fast lookup of existing hours
                        var existingHours = [String: Int]()
                        if let hours = dayData.hours {
                            for hourEntry in hours {
                                if let hour = hourEntry.hour {
                                    existingHours[hour] = hourEntry.recordCount ?? 0
                                }
                            }
                        }
                        
                        // Create an array to hold the updated hours data
                        var updatedHours = [Hour]()
                        
                        // Iterate over the 24 hours of the day
                        for hour in 0..<24 {
                            let hourString = String(format: "%@%02d", dayData.day ?? "", hour)
                            let recordCount = existingHours[hourString] ?? 0
                            let hourEntry = Hour(hour: hourString, recordCount: recordCount)
                            updatedHours.append(hourEntry)
                        }
                        
                        // Replace the existing hours array with the updated one
                        dayDataArray[index].hours = updatedHours
                    }
                    
                    // Sort the day data array by day in descending order
                    let dayDataArraySorted = dayDataArray.sorted(by: { a, b in
                        return a.day ?? "" > b.day ?? ""
                    })
                    dayRecordModel = dayDataArraySorted
                    
                    let dayData = try JSONDecoder().decode([DayData].self, from: data)
                    let dayDataSorted = dayData.sorted { a, b in
                        return a.day > b.day
                    }
                    setDayColumn(dayDataSorted)
                } catch {
                    print("Error reading JSON file: \(error.localizedDescription)")
                }
            }
        }

    private func setDayColumn(_ dayDataArray: [DayData]) {
        dayArray = dayDataArray.compactMap { Int($0.day.prefix(8).suffix(2)) }
    }
}
