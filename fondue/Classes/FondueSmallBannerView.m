#import "FondueSmallBannerView.h"


@implementation FondueSmallBannerView
-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    [self setup];
  } return self;
}


-(void) setup {
  [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self setBackgroundColor:[UIColor secondarySystemBackgroundColor]];
  [self setClipsToBounds:YES];
  [self.layer setCornerRadius:15];

  [self addImageView];
  [self addTitleLabel];
  [self addMessageLabel];
}


-(void) addImageView {
  imageView = [UIImageView new];
  [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [imageView setClipsToBounds:YES];
  [imageView.layer setCornerRadius:6];
  [self addSubview:imageView];

  [imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:12].active = YES;
  [imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12].active = YES;
  [imageView.widthAnchor constraintEqualToConstant:30].active = YES;
  [imageView.heightAnchor constraintEqualToConstant:30].active = YES;
  [self.bottomAnchor constraintEqualToAnchor:imageView.bottomAnchor constant:12].active = YES;
}


-(void) addTitleLabel {
  titleLabel = [UILabel new];
  [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [titleLabel setFont:[UIFont boldSystemFontOfSize:[[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] pointSize]]];
  [titleLabel setTextAlignment:NSTextAlignmentLeft];
  [titleLabel setTextColor:[UIColor labelColor]];
  [self addSubview:titleLabel];

  [titleLabel.centerYAnchor constraintEqualToAnchor:imageView.centerYAnchor].active = YES;
  [titleLabel.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:12].active = YES;
}


-(void) addMessageLabel {
  messageLabel = [UILabel new];
  [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [messageLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
  [messageLabel setTextAlignment:NSTextAlignmentLeft];
  [messageLabel setTextColor:[UIColor secondaryLabelColor]];
  [self addSubview:messageLabel];

  [messageLabel.centerYAnchor constraintEqualToAnchor:imageView.centerYAnchor].active = YES;
  [messageLabel.leadingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor constant:12].active = YES;
  [messageLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant:-20].active = YES;
}


-(void) configure:(NCNotificationRequest *)arg1 {
  UIImage *image = [UIImage _applicationIconImageForBundleIdentifier:arg1.bulletin.section format:10 scale:[UIScreen mainScreen].scale];

  [imageView setImage:image];
  [titleLabel setText:[arg1.bulletin.header uppercaseString]];
  // [titleLabel setTextColor:[self getDominantColorFromImage:image]];
  if(arg1.bulletin.message != nil) {
    [messageLabel setText:arg1.bulletin.message];
  } else {
    [messageLabel setText:arg1.bulletin.title];
  }
}


// This is where my colour detection code was, only for my eyes though.
@end
