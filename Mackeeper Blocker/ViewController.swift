//
//  ViewController.swift
//  Mackeeper Blocker
//
//  Created by Bryce Davis on 8/13/15.
//  Copyright (c) 2015 Bryce Davis. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var path:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func loadScript() {
        let bundle = NSBundle.mainBundle()
        path = bundle.pathForResource("mackeeper_blocker", ofType: "sh")
        
        println(path!)
    }

    @IBAction func blockMackeeper(sender: AnyObject) {
        loadScript()
        
        if let pathStr = path {
            let task = NSTask()
            task.launchPath = "/usr/bin/open"
            task.arguments = ["-a", "Terminal.app", pathStr]
            
            let pipe = NSPipe()
            task.standardOutput = pipe
            task.launch()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            print(output!)
        }
    }

}

