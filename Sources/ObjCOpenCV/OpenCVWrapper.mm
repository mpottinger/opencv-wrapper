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
    //cvtColor(dst, dst, COLOR_GRAY2BGR);
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
    Mat edges;

    UIImageToMat(image, src);
    cv::cvtColor(src, gray, COLOR_BGR2GRAY);
    cv::Canny(gray, edges, 50, 200, 3);

    float rho = 1.0;  // distance resolution in pixels of the Hough grid
    float theta = CV_PI / 180; // angular resolution in radians of the Hough grid
    float threshold = 15.0; // minimum number of votes (intersections in Hough grid cell)
    float minLineLength = 50.0; // minimum number of pixels making up a line
    float maxLineGap = 20.0; // maximum gap in pixels between connectable line segments

    // Run Hough on edge detected image
    // Output "lines" is an array containing endpoints of detected line segments
    std::vector<cv::Vec4i> lines;
    cv::HoughLinesP(edges, lines, rho, theta, threshold, minLineLength, maxLineGap);

    Mat result_lines;
    cv::cvtColor(edges, result_lines, COLOR_GRAY2BGR);
    // Draw lines on image if there are any
    if (lines.size() > 0) {
        for (size_t i = 0; i < lines.size(); i++) {
            cv::Vec4i l = lines[i];
            cv::line(result_lines, cv::Point(l[0], l[1]), cv::Point(l[2], l[3]), cv::Scalar(0, 0, 255), 3, cv::LINE_AA);
            // visualize the end points of the detected lines
            cv::circle(result_lines, cv::Point(l[0], l[1]), 3, cv::Scalar(0, 255, 0), -1);
            cv::circle(result_lines, cv::Point(l[2], l[3]), 3, cv::Scalar(0, 255, 0), -1);
        }
    }
    result = MatToUIImage(result_lines);
    return result;
}
@end
