

#import "UIImage+MultiFormat.h"
#import "UIImage+GIF.h"
#import "NSData+ImageContentType.h"

#ifdef SD_WEBP
#import "UIImage+WebP.h"
#endif

@implementation UIImage (MultiFormat)

+ (UIImage *)sd_imageWithData:(NSData *)data {
    UIImage *image;
    NSString *imageContentType = [NSData contentTypeForImageData:data];
    if ([imageContentType isEqualToString:@"image/gif"]) {
        image = [UIImage sd_animatedGIFWithData:data];
    }
#ifdef SD_WEBP
    else if ([imageContentType isEqualToString:@"image/webp"])
    {
        image = [UIImage sd_imageWithWebPData:data];
    }
#endif
    else {
        image = [[UIImage alloc] initWithData:data];
    }


    return image;
}

@end
