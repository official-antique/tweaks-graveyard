#import <UIKit/UIKit.h>
#import "../Headers.h"


@interface FondueSmallBannerView : UIView {
  NCNotificationRequest *request;

  UIImageView *imageView;
  UILabel *titleLabel, *messageLabel;
}

-(void) configure:(NCNotificationRequest *)arg1;
@end
