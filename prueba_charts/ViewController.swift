//
//  ViewController.swift
//  prueba_charts
//
//  Created by dti on 25/03/19.
//  Copyright © 2019 dti. All rights reserved.
//

import UIKit
import Charts
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var ChartView: LineChartView!

    var cursosMatriculados = [ChartDataEntry]()
    var cursosAprobados    = [ChartDataEntry]()
    var extras               = Array<Array<String>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        Request.getCursosAprobablesAprobadosXCiclo { ( data: Data?, response: URLResponse?, error:Error?) -> Void in
            let jsonData = Request.processRequestData(response: response, data: data, error: error)
            let errorType = Request.validateResponseData(jsonData: jsonData, response: response)
            if errorType == Request.ErrorC.none {
               
                if let jsonArray = jsonData as? NSDictionary {
                    _ = jsonArray["rowCount"] as! Int
                    let data     = jsonArray["data"] as? NSArray
                    for (index,cicloData) in (data?.enumerated().makeIterator())! {
                        let cicloDat = cicloData as! NSDictionary
//                        "ciclo_desc": "1993-2",
//                        "ciclo_f_iinicio": "23/08/1993",
//                        "cursos_matriculados": "5,0",
//                        "cursos_aprobados": "5,0"
                        let ciclo_desc = cicloDat["ciclo_desc"] as! String
                        let ciclo_f_iinicio = cicloDat["ciclo_f_iinicio"] as! String
                        
                      var cursoMatriculado = cicloDat["cursos_matriculados"] as! String
                         cursoMatriculado = cursoMatriculado.replacingOccurrences(of: ",", with: ".")
                      var cursoAprobado    = cicloDat["cursos_aprobados"]   as! String
                         cursoAprobado     = cursoAprobado.replacingOccurrences(of: ",", with: ".")
                        
                        var value = ChartDataEntry(x: Double(index), y: Double(cursoMatriculado)!)
                        self.cursosMatriculados.append(value)
                        
                        value = ChartDataEntry(x: Double(index), y: Double(cursoAprobado)!)
                        self.cursosAprobados.append(value)
                        
                        var cicloExtras = Array<String>()
                        cicloExtras.append(ciclo_desc)
                        cicloExtras.append(ciclo_f_iinicio)
                        self.extras.insert(cicloExtras, at: index)

                    }

                    
                }
                
                let myChart = MyChart(chart: self.ChartView, text: "Creditos matriculados vs aprobados", extras: self.extras)
                myChart.addPrimaryDataset(values: self.cursosMatriculados, label: "Matriculados")
                myChart.addSecundayDataset( values: self.cursosAprobados, label: "Aprobados")
                
             
            }
        }
        

        
    }
}

