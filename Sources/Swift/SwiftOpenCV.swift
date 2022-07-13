import UIKit
import ObjCOpenCV

public struct SwiftOpenCV {
    public static func openCVVersionString() -> String {
        return OpenCVWrapper.openCVVersionString()
    }

    // canny edge detection
    public static func canny(_ image: UIImage) -> UIImage? {
        return OpenCVWrapper.canny(image)
    }
    // lines detection
    public static func houghLines(_ image: UIImage) -> UIImage? {
        return OpenCVWrapper.houghLines(image)
    }
}
