#import <UIKit/UIKit.h>
#import "../Headers.h"


@interface FondueFullScreenBannerView : UIView {
  NCNotificationRequest *request;

  UIView *contentView;
  UIImageView *imageView;
  UILabel *titleLabel, *subtitleLabel;

  NSLayoutConstraint *centerYConstraint;
}

-(void) configure:(NCNotificationRequest *)arg1;
@end
