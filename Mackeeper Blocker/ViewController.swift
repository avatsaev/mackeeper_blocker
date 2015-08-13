//
//  ViewController.swift
//  Mackeeper Blocker
//
//  Created by Bryce Davis on 8/13/15.
//  Copyright (c) 2015 Bryce Davis. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let file = "mackeeper_blocker.sh"
    let contents = "#!/usr/bin/ruby\n\n" +
    "#Author: Vatsaev Aslan (@avatsaev)\n" +
    "#Repository: https://github.com/avatsaev/mackeeper_blocker\n" +
    "#GUI Author: Bryce Davis (@mahimahi42)\n" +
    "#GUI Repository: https://github.com/mahimahi42/mackeeper_blocker\n\n" +
    "#request root previleges in order to modify hosts file\n" +
    "if ENV[\"USER\"] != \"root\"\n" +
    "\texec(\"sudo #{ENV['_']} #{ARGV.join(' ')}\")\n" +
    "\texit\n" +
    "end\n\n" +
    "#initiate domain list array\n" +
    "mk_address_list = [\n" +
    "\"mackeeperapp.mackeeper.com\",\n" +
    "\"mackeeperapp2.mackeeper.com\",\n" +
    "\"mackeeperapp3.mackeeper.com\",\n" +
    "\"mackeeper.com\"\n" +
    "]\n\n" +
    "#open hosts file in append mode\n" +
    "open('/etc/hosts', 'a') do |f|\n" +
    "\t#for every domain name\n" +
    "\tmk_address_list.each do |addr|\n" +
    "\t\tp \"Adding #{addr} to hosts file...\"\n\n" +
    "\t\tf.puts \"127.0.0.1 #{addr}\"\n" +
    "\t\tp \"✔︎ Done.\"\n" +
    "\tend\n" +
    "end\n\n" +
    "p \"-----------\"\n" +
    "p \"✔︎ Script finished running.\"\n\n" +
    "exit"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func createScript() {
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            
            //writing
            contents.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
            
            println("Wrote \(path)")
        }
    }

    @IBAction func blockMackeeper(sender: AnyObject) {
        createScript()
    }

}

