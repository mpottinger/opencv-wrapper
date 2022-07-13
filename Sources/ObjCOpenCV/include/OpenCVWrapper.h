#import <Foundation/Foundation.h>

@class UIImage;

@interface OpenCVWrapper : NSObject

+ (NSString *)openCVVersionString;
+ (UIImage *)Canny:(UIImage *)image;

@end
