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

+ (UIImage *)canny:(UIImage *)image {
    @try {
        return [OpenCVWrapper _cannyInternal:image];
    } @catch (...) {
        return nil;
    }
}

+ (UIImage *)_cannyInternal:(UIImage *)image{
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
    // convert to color
    cvtColor(dst, dst, COLOR_GRAY2BGR);
    result = MatToUIImage(dst);
    return result;
}
@end
