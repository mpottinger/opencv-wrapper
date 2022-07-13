import UIKit
import ObjCOpenCV

public struct SwiftOpenCV {
    public static func openCVVersionString() -> String {
        return OpenCVWrapper.openCVVersionString()
    }

    public static func Canny(_ image: UIImage) -> UIImage? {
        return OpenCVWrapper.Canny(image)
    }
}
