
import UIKit
import MetalKit
import ModelIO

class ViewController: UIViewController {
    
    var mtkView: MTKView!
    var renderer: Renderer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printClassAndFunc()

        mtkView = MTKView()
        mtkView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mtkView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[mtkView]|", options: [], metrics: nil, views: ["mtkView" : mtkView as Any]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mtkView]|", options: [], metrics: nil, views: ["mtkView" : mtkView as Any]))
        
        let device = MTLCreateSystemDefaultDevice()!
        mtkView.device = device
        
        mtkView.colorPixelFormat = .bgra8Unorm_srgb
        mtkView.depthStencilPixelFormat = .depth32Float
        
        renderer = Renderer(view: mtkView, device: device)
        mtkView.delegate = renderer
    }
}

