#import <UIKit/UIKit.h>
#import "FondueFullScreenBannerView.h"
#import "FondueSmallBannerView.h"


@interface FondueBannerWindow : UIWindow {
  FondueFullScreenBannerView *fondueFullScreenBannerView;
  FondueSmallBannerView *fondueSmallBannerView;

  NSLayoutConstraint *bottomConstraint, *topConstraint;
}

-(void) presentSmallBannerWithRequest:(NCNotificationRequest *)arg1;
-(void) presentFullScreenBannerWithRequest:(NCNotificationRequest *)arg1;
@end
