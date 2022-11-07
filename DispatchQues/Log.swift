//
//  Log.swift
//  DispatchQues
//
//  Created by Muhammad Tafani Rabbani on 07/11/22.
//

import SwiftUI

enum Log{
    static func queue(action:String){
        DispatchQueue.log(action:action)
    }
    
    static func location(filename:String,functionName : String = #function, lineNumber : Int = #line){
        print("----------------------------------------------------------------------------------------------------------")
        print("Called by \(filename.components(separatedBy: "/").last ?? filename) - \(functionName) at line \(lineNumber)")
    }
}


extension DispatchQueue{
    static func log(action:String){
        print("""
              \(action):
              🚨 \(String(validatingUTF8: __dispatch_queue_get_label(nil))!)
              ⛳️ \(Thread.current)
              
              """)
    }
}
