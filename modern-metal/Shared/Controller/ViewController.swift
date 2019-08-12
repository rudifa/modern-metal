//
//  ViewController.swift
//  modern-metal-macOS
//
//  Created by Rudolf Farkas on 09.08.19.
//  Copyright © 2019 Metal By Example. All rights reserved.
//

import MetalKit

class ViewController: NUViewController {
    // .storyboard declares view as NSView
    // Get access to the GPU described as a 'device' in Metal
    var device = MTLCreateSystemDefaultDevice()!
    var mtkView: MTKView!
    var renderer: Renderer!

    let color = MTLClearColor(red: 1.0,
                              green: 0.5,
                              blue: 0.5,
                              alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        printClassAndFunc()

        mtkView = MTKView(frame: view.bounds, device: device)
        view.addSubview(mtkView)

        // The MTKView needs a device instance to work with
        mtkView.device = device
        // The clear color is displayed when the view 'clears'
        mtkView.clearColor = color
        mtkView.depthStencilPixelFormat = .depth32Float

        mtkView.translatesAutoresizingMaskIntoConstraints = false
        //        mtkView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //        mtkView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mtkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mtkView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        //        view.addConstraintsWithFormat(format: "H:|->=0-[v0]->=0-|", views: mtkView)
        //        view.addConstraintsWithFormat(format: "V:|[v0]|", views: mtkView)

        // Give myView a 1:1 aspect ratio
        mtkView.heightAnchor.constraint(equalTo: mtkView.widthAnchor, multiplier: 1.0).isActive = true
        mtkView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // Create Renderer and connect it as delegate for drawing
        renderer = Renderer(view: mtkView)
        mtkView.delegate = renderer
    }
}
