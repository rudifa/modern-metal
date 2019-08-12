#  modern-metal

This project is based on the article [Writing a Modern Metal App from Scratch: Part 2](http://metalbyexample.com/modern-metal-2/) by Warren Moore (Jul 2018). It was forked from the corresponding [github repository](https://github.com/metal-by-example/modern-metal).

See also:

[Writing a Modern Metal App from Scratch: Part 1](http://metalbyexample.com/modern-metal-1/)

[Making Your First Circle Using Metal Shaders](https://medium.com/@barbulescualex/making-your-first-circle-using-metal-shaders-1e5049ec8505)

[Metal 3D Graphics Part 1: Basic Rendering](https://donaldpinckney.com/metal/2018/07/05/metal-intro-1.html)

### Search for a canonical class/file structure for a Metal app

`ViewController` creates the `MTKView` and `Renderer` instances, connects them and constrains the `MTKView` within its own `view`.

`ViewController` can also create and manage UI elements like buttons, labels and gesture recognizer, as is usual for this component, while it leaves to the `Renderer` the creation of and interactions with the `MTLDevice` instance .
```
import MetalKit

class ViewController: NUViewController {
    var mtkView: MTKView!
    var renderer: Renderer!

    override func viewDidLoad() {
        super.viewDidLoad()

        mtkView = MTKView()
        view.addSubview(mtkView)

        mtkView.translatesAutoresizingMaskIntoConstraints = false
        mtkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mtkView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mtkView.heightAnchor.constraint(equalTo: mtkView.widthAnchor, multiplier: 1.0).isActive = true
        mtkView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        renderer = Renderer(view: mtkView)
    }
}

```

`Renderer` instance completes the initialiation of the `MTKView` instance and connects itself to it (as `MTKViewDelegate`) and to a `MTLDevice` instance that represents the Metal hardware. `Renderer` also mediates between the model, the scene and the `draw` calls from the `MTKView`.

```
class Renderer: NSObject, MTKViewDelegate {
    let device: MTLDevice
    // ... device, model and scene items

    init(view: MTKView) {
        view.colorPixelFormat = .bgra8Unorm_srgb
        view.depthStencilPixelFormat = .depth32Float

        let device = MTLCreateSystemDefaultDevice()!
        view.device = device
        self.device = device

        commandQueue = device.makeCommandQueue()!
        // initialize device items ...

        super.init()

        view.delegate = self
    }

    ...
}

extension Renderer: MTKViewDelegate {

    func mtkView(_: MTKView, drawableSizeWillChange _: CGSize) {}

    func draw(in view: MTKView) {
      ...
    }
}

```
