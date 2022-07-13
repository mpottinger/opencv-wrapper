#import <Foundation/Foundation.h>

@class UIImage;

@interface OpenCVWrapper : NSObject

+ (NSString *)openCVVersionString;

// canny edge detector
+ (UIImage *)canny:(UIImage *)image;
// line detector (HoughLinesP)
+ (UIImage *)houghLines:(UIImage *)image;
@end
