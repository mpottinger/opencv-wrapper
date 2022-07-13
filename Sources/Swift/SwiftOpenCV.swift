import UIKit
import ObjCOpenCV

public struct SwiftOpenCV {
    public static func openCVVersionString() -> String {
        return OpenCVWrapper.openCVVersionString()
    }

    public static func canny(_ image: UIImage) -> UIImage? {
        return OpenCVWrapper.canny(image)
    }
}
