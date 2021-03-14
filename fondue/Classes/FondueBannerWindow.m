#import "FondueBannerWindow.h"


@implementation FondueBannerWindow
-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView * view = [super hitTest:point withEvent:event];
  return view == self ? nil : view;
}


-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    [self addFullScreenBannerView];
    [self addSmallBannerView];
  } return self;
}


-(void) addFullScreenBannerView {
  fondueFullScreenBannerView = [FondueFullScreenBannerView new];
  [fondueFullScreenBannerView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [fondueFullScreenBannerView setAlpha:0];
  [self addSubview:fondueFullScreenBannerView];

  [fondueFullScreenBannerView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
  [fondueFullScreenBannerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
  [fondueFullScreenBannerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
  [fondueFullScreenBannerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
}


-(void) addSmallBannerView {
  fondueSmallBannerView = [FondueSmallBannerView new];
  [fondueSmallBannerView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [fondueSmallBannerView setAlpha:0];
  [self addSubview:fondueSmallBannerView];

  bottomConstraint = [fondueSmallBannerView.bottomAnchor constraintEqualToAnchor:self.topAnchor];
  [bottomConstraint setActive:YES];

  topConstraint = [fondueSmallBannerView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:12];

  [fondueSmallBannerView.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:12].active = YES;
  [fondueSmallBannerView.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:-12].active = YES;
}


-(void) presentSmallBannerWithRequest:(NCNotificationRequest *)arg1 {
  [fondueSmallBannerView configure:arg1];

  [bottomConstraint setActive:NO];
  [topConstraint setActive:YES];
  [UIView animateWithDuration:0.33 animations:^{
    [self layoutIfNeeded];
    [fondueSmallBannerView setAlpha:1];
  }];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [bottomConstraint setActive:YES];
    [topConstraint setActive:NO];
    [UIView animateWithDuration:0.33 animations:^{
      [self layoutIfNeeded];
      [fondueSmallBannerView setAlpha:1];
    }];
  });
}


-(void) presentFullScreenBannerWithRequest:(NCNotificationRequest *)arg1 {
  [fondueFullScreenBannerView configure:arg1];

  [UIView animateWithDuration:0.33 animations:^{
    [fondueFullScreenBannerView setAlpha:1];
  }];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.33 animations:^{
      [fondueFullScreenBannerView setAlpha:0];
    }];
  });
}
@end
