

#import <UIKit/UIKit.h>

#define kMinProgress 0.0001

@class MJPhotoBrowser;
@class MJPhoto;

@interface MJPhotoLoadingView : UIView
@property (nonatomic) float progress;

- (void)showLoading;
- (void)showFailure;
@end
