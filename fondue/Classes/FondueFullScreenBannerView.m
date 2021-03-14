#import "FondueFullScreenBannerView.h"

@implementation FondueFullScreenBannerView
-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    [self setup];
  } return self;
}


-(void) setup {
  [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self setBackgroundColor:[UIColor systemBackgroundColor]];

  [self addContentView];
  [self addImageView];
  [self addTitleLabel];
  [self addSubtitleLabel];
}


-(void) addContentView {
  contentView = [UIView new];
  [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [contentView setAlpha:0];
  [self addSubview:contentView];

  [contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
  centerYConstraint = [contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:100];
  [centerYConstraint setActive:YES];
  [contentView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.5].active = YES;
}


-(void) addImageView {
  imageView = [UIImageView new];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [contentView addSubview:imageView];

  [imageView.topAnchor constraintEqualToAnchor:contentView.topAnchor].active = YES;
  [imageView.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor].active = YES;
  [imageView.trailingAnchor constraintEqualToAnchor:contentView.trailingAnchor].active = YES;
  [imageView.heightAnchor constraintEqualToAnchor:imageView.widthAnchor].active = YES;
}


-(void) addTitleLabel {
  titleLabel = [UILabel new];
  [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle3]];
  [titleLabel setTextAlignment:NSTextAlignmentCenter];
  [titleLabel setTextColor:[UIColor labelColor]];
  [contentView addSubview:titleLabel];

  [titleLabel.topAnchor constraintEqualToAnchor:imageView.bottomAnchor constant:16].active = YES;
  [titleLabel.leadingAnchor constraintEqualToAnchor:imageView.leadingAnchor].active = YES;
  [titleLabel.trailingAnchor constraintEqualToAnchor:imageView.trailingAnchor].active = YES;
}


-(void) addSubtitleLabel {
  subtitleLabel = [UILabel new];
  [subtitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [subtitleLabel setFont:[UIFont boldSystemFontOfSize:[[UIFont preferredFontForTextStyle:UIFontTextStyleBody] pointSize]]];
  [subtitleLabel setTextAlignment:NSTextAlignmentCenter];
  [contentView addSubview:subtitleLabel];

  [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:16].active = YES;
  [subtitleLabel.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor].active = YES;
  [subtitleLabel.trailingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor].active = YES;
  [contentView.bottomAnchor constraintEqualToAnchor:subtitleLabel.bottomAnchor].active = YES;
}


-(void) configure:(NCNotificationRequest *)arg1 {
  UIImage *image = [UIImage _applicationIconImageForBundleIdentifier:arg1.bulletin.section format:10 scale:[UIScreen mainScreen].scale];

  [imageView setImage:image];
  if(arg1.bulletin.message != nil) {
    [titleLabel setText:arg1.bulletin.message];
  } else {
    [titleLabel setText:arg1.bulletin.title];
  }
  [subtitleLabel setText:[arg1.bulletin.header uppercaseString]];
  // [subtitleLabel setTextColor:[self getDominantColorFromImage:image]];


  [centerYConstraint setConstant:0];
  [UIView animateWithDuration:0.33 delay:0.33 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    [self layoutIfNeeded];
    [contentView setAlpha:1];
  } completion:nil];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    [centerYConstraint setConstant:100];
    [UIView animateWithDuration:0.33 animations:^{
      [self layoutIfNeeded];
      [contentView setAlpha:0];
    }];
  });
}


// This is where my colour detection code was, only for my eyes though.
@end
