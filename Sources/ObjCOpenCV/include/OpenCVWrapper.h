#import <Foundation/Foundation.h>

@class UIImage;

@interface OpenCVWrapper : NSObject

+ (NSString *)openCVVersionString;
+ (UIImage *)canny:(UIImage *)image;

@end
