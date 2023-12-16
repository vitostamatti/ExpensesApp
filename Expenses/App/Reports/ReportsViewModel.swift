//
//  ReportsViewModel.swift
//  Expenses
//
//  Created by Vito Stamatti on 10/12/23.
//

import SwiftUI

struct ReportDataElement:Identifiable {
    let id:UUID = UUID()
    let date:Date
    let value:Double
}

struct CategoriesReportDataElement {
    let categoryName:String
    let value:Double
}

class ReportsViewModel: ObservableObject {
    
    @Published var totalBalanceResult:Double = 0
    
    @Published var weeklyPercentageChange:Double = 0
    @Published var monthlyPercentageChange:Double = 0
    
    @Published var monthlyBalanceResult:[ReportDataElement] = []
    @Published var dailyBalanceResult:[ReportDataElement] = []
    @Published var categoriesResult:[CategoriesReportDataElement] = []
    
    func totalBalance(expenses:[Expense]) {
        totalBalanceResult = expenses.map({$0.value}).reduce(0,+)
    }
    
    func weeklyPercentageChange(expenses:[Expense]) {
        let calendar = Calendar.current
        
        let today = Date()
        
        let firstDayOfWeek = calendar.date(bySetting: .weekday, value: 1, of: today)!
        
        let currentWeek = calendar.date(byAdding: .day, value: -7, to: firstDayOfWeek)!
        
        let previousWeek = calendar.date(byAdding: .day, value: -14, to: currentWeek)!
        
        let totalCurrentWeek:Double = expenses.filter({
            $0.schedule.start >= currentWeek && $0.schedule.start < firstDayOfWeek
        }).map({$0.value}).reduce(0.0,+)
        
        let totalPreviousWeek:Double = expenses.filter({
            $0.schedule.start >= previousWeek &&  $0.schedule.start < currentWeek
        }).map({$0.value}).reduce(0.0,+)
        
        weeklyPercentageChange = (totalCurrentWeek - totalPreviousWeek) / totalPreviousWeek

    }
    
    func monthlyPercentageChange(expenses:[Expense]) {
        let calendar = Calendar.current
        
        let today = Date()
        
        let firstDateOfMonth = calendar.date(bySetting: .day, value: 1, of: today)!
        
        let endCurrentMonth = calendar.date(byAdding: .month, value: -1, to: firstDateOfMonth)!
        
        let currentMonth = calendar.date(byAdding: .month, value: -2, to: firstDateOfMonth)!
        
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth)!
                
        let totalCurrentMonth: Double = expenses.filter({
            $0.schedule.start > currentMonth && $0.schedule.start <= endCurrentMonth
        }).map({$0.value}).reduce(0.0,+)
        
        let totalPreviousMonth: Double = expenses.filter({
            $0.schedule.start > previousMonth &&  $0.schedule.start <= currentMonth
        }).map({$0.value}).reduce(0.0,+)
        
        monthlyPercentageChange = (totalCurrentMonth - totalPreviousMonth) / totalPreviousMonth
    }
    
    func categoriesBalance(expenses:[Expense]) {
  
        let categories = Array(Set(expenses.flatMap{$0.categories}))

        var result:[CategoriesReportDataElement] = []
        
        let negativeExpenses = expenses.filter({$0.value < 0})
        
        for category in categories {
            let total = negativeExpenses.filter({$0.categories.contains(category)}).map({-$0.value}).reduce(0.0,+)
            result.append(
                CategoriesReportDataElement(categoryName: category.name, value: total)
            )
        }
        
        let resultTotal = result.map{$0.value}.reduce(0.0,+)
        
        categoriesResult = result.map{(element) -> CategoriesReportDataElement in
            return CategoriesReportDataElement(categoryName: element.categoryName, value: element.value/resultTotal )
        }.sorted{$0.value < $1.value}
        
    }
    
    
    func dailyBalance(expenses:[Expense]) {
        let calendar = Calendar.current
        
        let toDate = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: .now),
            month: calendar.component(.month, from: .now),
            day:calendar.component(.day, from: .now)
        ))!
        
        let fromDate = calendar.date(byAdding: .day, value: -6, to: toDate)!
        
        let dateRange = createDailyDateRange(from: fromDate, to: toDate)
        
        let filteredExpenses = expenses.filter({
            $0.schedule.start >= fromDate &&
            $0.schedule.start <= toDate
        })
        
        let grouped = Dictionary(
            grouping: filteredExpenses, by: {[
                calendar.component(.year, from: $0.schedule.start),
                 calendar.component(.month, from: $0.schedule.start),
                calendar.component(.day, from: $0.schedule.start)
            ]}
        )
        
        var result = grouped.keys.map { (key) -> ReportDataElement in
            let groupedExpenses = grouped[key]!
            let groupedValue = groupedExpenses.map{$0.value}.reduce(0.0, +)
            let date = calendar.date(
                from: DateComponents(year:key[0], month:key[1], day:key[2])
            )!
            return ReportDataElement(date: date, value: groupedValue)
        }
        
        for date in dateRange {
            if result.first(where:{calendar.isDate($0.date, equalTo: date, toGranularity: .day)}) == nil {
                result.append(ReportDataElement(date: date, value: 0.0))
            }
        }
 
        dailyBalanceResult = result.sorted{$0.date < $1.date}
    }
    
    
    func monthlyBalance(expenses:[Expense]) {
        
        let calendar = Calendar.current
        
        let toDate = calendar.date(bySetting: .day, value: 1, of: .now)!
        
        let fromDate = calendar.date(byAdding: .month, value: -3, to: toDate)!
        
        let dateRange = createMonthlyDateRange(from: fromDate, to: toDate)
        
        let filteredExpenses = expenses.filter({ $0.schedule.start >= fromDate })
        
        let grouped = Dictionary(
            grouping: filteredExpenses, by: {[
                calendar.component(.year, from: $0.schedule.start),
                 calendar.component(.month, from: $0.schedule.start)
            ]}
        )
          
        var result = grouped.keys.map { (key) -> ReportDataElement in
            let monthlyExpenses = grouped[key]!
            
            let monthlyBalance = monthlyExpenses.map{$0.value}.reduce(0.0, +)
            
            let date = calendar.date(from: DateComponents(year:key[0], month:key[1], day:1))!
            
            return ReportDataElement(date: date, value: monthlyBalance)

        }
        
        for date in dateRange {
            if result.first(where:{$0.date == date}) == nil {
                result.append(ReportDataElement(date: date, value: 0))
            }
        }
        
        monthlyBalanceResult = result.sorted{$0.date < $1.date}
    }

    
    private func createMonthlyDateRange(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date < toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .month, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    
    private func createDailyDateRange(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date < toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}
