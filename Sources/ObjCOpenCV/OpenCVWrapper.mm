#import "OpenCVWrapper.h"

#ifdef __cplusplus
#undef NO
#undef YES
#import <opencv2/opencv.hpp>
#endif

#include <opencv2/highgui.hpp>
#import <opencv2/imgcodecs/ios.h>

#import <UIKit/UIKit.h>

@implementation OpenCVWrapper

using namespace cv;
using namespace std;

+ (NSString *)openCVVersionString {
    return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
}

+ (UIImage *)Canny:(UIImage *)image {
    @try {
        return [OpenCVWrapper _CannyInternal:image];
    } @catch (...) {
        return nil;
    }
}

+ (UIImage *)_CannyInternal:(UIImage *)image{
    if (!image) {
        return nil;
    }
    
    UIImage *result = image;
    
    Mat src;
    Mat gray;
    Mat dst;

    UIImageToMat(image, src);
    cvtColor(src, gray, COLOR_BGR2GRAY);
    Canny(gray, dst, 50, 200, 3);
    MatToUIImage(dst, result);
    return result;
}
@end
