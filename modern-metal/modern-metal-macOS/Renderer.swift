//
//  Renderer.swift
//  modern-metal-macOS
//
//  Created by Rudolf Farkas on 12.08.19.
//  Copyright © 2019 Metal By Example. All rights reserved.
//

import MetalKit

class Renderer: NSObject {
    let device: MTLDevice
    let mtkView: MTKView
    var commandQueue: MTLCommandQueue!
    var counter = 0

    init(view: MTKView, device: MTLDevice) {
        self.device = device
        self.mtkView = view
        // Create command queue to send commands to the GPU
        commandQueue = device.makeCommandQueue()
        super.init()
        printClassAndFunc()
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        printClassAndFunc(info: "\(view) \(size)")
    }

    //    func mtkView(_: MTKView, drawableSizeWillChange _: CGSize) {
    //        printClassAndFunc()
    //    }

    func draw(in view: MTKView) {
        // printClassAndFunc()
        // Create the commandBuffer for the queue
        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            printClassAndFunc(info: "makeCommandBuffer failed")
            return
        }
        // Create the interface for the pipeline
        guard let renderDescriptor = view.currentRenderPassDescriptor else {
            printClassAndFunc(info: "view.currentRenderPassDescriptor missing")
            return
        }
        // Set a new background color
        renderDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 1, 1)

        // Create the command encoder, or the "inside" of the pipeline
        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor) else {
            printClassAndFunc(info: "makeRenderCommandEncoder failed")
            return
        }

        renderEncoder.endEncoding()
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
    }
}
