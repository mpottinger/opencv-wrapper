#import "OpenCVWrapper.h"

#ifdef __cplusplus
#undef NO
#undef YES
#import <opencv2/opencv.hpp>
#endif

#include <opencv2/highgui.hpp>
#import <opencv2/imgcodecs/ios.h>

#import <UIKit/UIKit.h>
#import <opencl-c-base.h>
#import <opencl-c.h>

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
    // compute the median of the single pixel intensities
    float median = 0;
    // vector to store the single pixel intensities
    vector<int> v;
    for (int i = 0; i < gray.rows; i++) {
        for (int j = 0; j < gray.cols; j++) {
            v.push_back(gray.at<uchar>(i, j));
        }
    }
    // sort the vector
    sort(v.begin(), v.end());
    // get the median
    if (v.size() % 2 == 0) {
        median = (v[v.size() / 2 - 1] + v[v.size() / 2]) / 2.0;
    } else {
        median = v[v.size() / 2];
    }

    /* apply automatic Canny edge detection using the computed median, lower and upper thresholds, just like the python example
    lower = int(max(0, (1.0 - sigma) * v))
    upper = int(min(255, (1.0 + sigma) * v))
    edged = cv2.Canny(image, lower, upper)
    */
    float sigma=0.33f;
    float lower = int(max(0.0f, (1.0f - sigma) * median));
    float upper = int(min(255.0f, (1.0f + sigma) * median));
    Canny(blurred, edges, lower, upper, 3);

    // convert to color
    cvtColor(edges, dst, COLOR_GRAY2BGR);
    result = MatToUIImage(dst);
    return result;
}

@end
