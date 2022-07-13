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

// line detector (HoughLinesP)
+ (UIImage *)houghLines:(UIImage *)image {
    @try {
        return [OpenCVWrapper _houghLinesPInternal:image];
    } @catch (...) {
        return nil;
    }
}

+ (UIImage *)_houghLinesPInternal:(UIImage *)image {
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

    // detect lines
    vector<Vec2f> lines;
    HoughLinesP(dst, lines, 1, CV_PI/180, 50, 50, 10);

    // draw lines
    for (size_t i = 0; i < lines.size(); i++) {
        float rho = lines[i][0], theta = lines[i][1];
        Point pt1, pt2;
        double a = cos(theta), b = sin(theta);
        double x0 = a*rho, y0 = b*rho;
        pt1.x = cvRound(x0 + 1000*(-b));
        pt1.y = cvRound(y0 + 1000*(a));
        pt2.x = cvRound(x0 - 1000*(-b));
        pt2.y = cvRound(y0 - 1000*(a));
        line(dst, pt1, pt2, Scalar(0,0,255), 3, LINE_AA);
    }

    // convert to color
    cvtColor(dst, dst, COLOR_GRAY2BGR);
    result = MatToUIImage(dst);
    return result;
}
@end
