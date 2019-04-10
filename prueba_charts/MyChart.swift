//
//  MyChart.swift
//  prueba_charts
//
//  Created by dti on 26/03/19.
//  Copyright © 2019 dti. All rights reserved.
//

import Foundation
import Charts

class MyChart {
    
    open var myChart : LineChartView
    open var myData  : LineChartData
    open var myExtras : Array<Array<String>>
    var defaultLineWidth : CGFloat = 3.5
    var defaultCircleRadious : CGFloat = 5.5
    
    // Recibe como parametro el View y el nombre del Chart
    init(chart: LineChartView, text: String, extras: Array<Array<String>>){
        myChart = chart
        myChart.chartDescription?.text = text
        myChart.drawGridBackgroundEnabled = false
        myChart.xAxis.drawAxisLineEnabled = false
        myChart.xAxis.enabled = false
        myChart.chartDescription?.enabled = false
        
        myExtras = extras
        
        let marker = BalloonMarker(  color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = myChart
        marker.extras = myExtras
        marker.minimumSize = CGSize(width: 80, height: 40)
        myChart.marker = marker
        
        
        myData = LineChartData()
    }
    
    
    
    // RED
    func addPrimaryDataset(values: [ChartDataEntry], label: String, color : [NSUIColor]? = [NSUIColor.blue]){
        
        let line = LineChartDataSet(values: values, label: label)
        line.colors = [NSUIColor.red]
        line.lineWidth = defaultLineWidth
        line.circleRadius = defaultCircleRadious
        line.drawValuesEnabled = false
        myData.addDataSet(line)
        myChart.data = myData
    }
    
    // BLUE
    func addSecundayDataset(values: [ChartDataEntry], label: String, color : [NSUIColor]? = [NSUIColor.red]){
        let line = LineChartDataSet(values: values, label: label)
        line.colors = [NSUIColor.blue]
        line.lineWidth = defaultLineWidth
        line.circleRadius = defaultCircleRadious
        line.drawValuesEnabled = false
        myData.addDataSet(line)
        myChart.data = myData
    }
    
    
    func dummyData1() -> [ChartDataEntry]{
        var numbers = [5,8,5,5,7,8,5,9,7]
        
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<numbers.count{
            let value = ChartDataEntry(x: Double(i), y: Double(numbers[i]))
            
            lineChartEntry.append(value)
        }
        return lineChartEntry
    }
    
    
    func dummyData2() -> [ChartDataEntry]{
        var numbers = [5,8,5,10,7,4,5,9,7]
        
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<numbers.count{
            let value = ChartDataEntry(x: Double(i), y: Double(numbers[i]))
            
            lineChartEntry.append(value)
        }
        return lineChartEntry
    }
}

