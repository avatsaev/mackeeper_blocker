//
//  ViewController.swift
//  Mackeeper Blocker
//
//  Created by Bryce Davis on 8/13/15.
//  Copyright (c) 2015 Bryce Davis. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    /// The path to the mackeeper_blocker.sh script
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
    
// MARK: Custom functions
    
    /**
        loadScript() will grab the included mackeeper_blocker.sh script and return
        the path as an Optional String.
    
        :returns: The path to the mackeeper_blocker script
    */
    func loadScript() -> String? {
        let bundle = NSBundle.mainBundle()
        path = bundle.pathForResource("mackeeper_blocker", ofType: "sh")
        
        return path
    }

    /**
        blockMackeeper() first loads in the mackeeper_blocker script, then spawns
        a new Terminal.app instance to run the script. Since the script updates
        the /etc/hosts file (owned by root), the user must type in their password.
    
        This is a less-scary option than doing it all from the command line, to some.
    
        :param: sender the UIButton from the GUI
    */
    @IBAction func blockMackeeper(sender: AnyObject) {
        path = loadScript()
        
        // Unwrap our path. It should always been found.
        if let pathStr = path {
            // Spawn a new NSTask to execute our script. Commands of the form:
            //   /usr/bin/open -a Terminal.app script_name
            // will spawn a new Terminal and execute the script.
            let task = NSTask()
            task.launchPath = "/usr/bin/open"
            task.arguments = ["-a", "Terminal.app", pathStr]
            
            // Most users won't see the output, but it's caught here...
            let pipe = NSPipe()
            task.standardOutput = pipe
            task.launch()
            
            // ...and output here. This is mostly for debugging.
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            print(output!)
        }
    }

}

