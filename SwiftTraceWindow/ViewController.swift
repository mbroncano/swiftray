//
//  ViewController.swift
//  SwiftTraceWindow
//
//  Created by Manuel Broncano Rodriguez on 11/15/15.
//  Copyright © 2015 Manuel Broncano Rodriguez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            Random.seed(1234)
//            let render = PathTracer(scene: CornellBox(), w: 320, h: 240)
            let render = RayTracer(scene: CornellBox(), w: 320, h: 240)
            
            while true {
                // render another frame
                let start = NSDate().timeIntervalSince1970
                render.render()
                let duration = NSDate().timeIntervalSince1970 - start
                print("Profiler: completed in \(duration * 1000)ms")
                
                // update the UI
                let image = render.framebuffer.cgImage()
                dispatch_async(dispatch_get_main_queue()) {
                    self.imageView!.image = NSImage(CGImage: image, size: NSZeroSize)
                    self.view.window!.title = "Samples \(render.framebuffer.samples)"
                }
            }
        }

        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }


}

