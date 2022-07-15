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
    Mat blurred;
    Mat edges;
    Mat dst;

    UIImageToMat(image, src);
    cvtColor(src, gray, COLOR_BGR2GRAY);
    GaussianBlur(gray, blurred, Size(3, 3), 0, 0, BORDER_DEFAULT);
    float lower = 10;
    float upper = 200;
    // apply the edge detector
    Canny(blurred, edges, lower, upper, 3);

    // convert to color
    cvtColor(edges, dst, COLOR_GRAY2BGR);
    result = MatToUIImage(dst);
    return result;
}

@end
