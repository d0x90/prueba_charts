//
//  MyMarker.swift
//  prueba_charts
//
//  Created by dti on 27/03/19.
//  Copyright © 2019 dti. All rights reserved.
//

import Foundation
import Charts

class MyMarker : MarkerView {
    var text = ""
    
    
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    override func draw(context: CGContext, point: CGPoint) {

    }
    
    
    override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        return CGPoint()
    }
    
}
