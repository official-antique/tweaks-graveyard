#import "BlotsView.h"
#import "UIView+YGPulseView.h"

@implementation UIView (Rounded)
-(void) createMaskWithCornerRadius:(CGFloat)radius {
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
  CAShapeLayer *mask = [CAShapeLayer layer];
  [mask setPath:[path CGPath]];
  [self.layer setMask:mask];
}
@end


@implementation BlotCell
@synthesize iconImageView;
-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    iconImageView = (SBIconImageView *)[[NSClassFromString(@"SBIconImageView") alloc] init];
    [iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:iconImageView];

    [self addConstraintToItem:self attribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual toItem:iconImageView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual toItem:iconImageView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual toItem:iconImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeTrailing relation:NSLayoutRelationEqual toItem:iconImageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
  } return self;
}

-(void) layoutSubviews {
  [super layoutSubviews];
  dispatch_async(dispatch_get_main_queue(), ^(){
    [iconImageView createMaskWithCornerRadius:2];
  });
}


-(void) addConstraintToItem:(UIView *)firstItem attribute:(NSLayoutAttribute)firstAttribute relation:(NSLayoutRelation)relation toItem:(UIView *)secondItem attribute:(NSLayoutAttribute)secondAttribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:relation toItem:secondItem attribute:secondAttribute multiplier:multiplier constant:constant]];
}
@end


@implementation Colour
@end


@implementation DotCell
@synthesize iconImageView, dotView;
-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    iconImageView = (SBIconImageView *)[[NSClassFromString(@"SBIconImageView") alloc] init];

    dotView = [[UIView alloc] init];
    [dotView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:dotView];

    [self addConstraintToItem:self attribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual toItem:dotView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual toItem:dotView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual toItem:dotView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeTrailing relation:NSLayoutRelationEqual toItem:dotView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
  } return self;
}

-(void) layoutSubviews {
  [super layoutSubviews];
  [dotView createMaskWithCornerRadius:self.bounds.size.height / 2];
  //[self setColorForColor:[self coloursForImage:iconImageView.displayedImage forEdge:2][@"primary"] withSecondaryColor:[self getAverageColor:iconImageView.displayedImage]];
}


-(void) setColorForColor:(UIColor *)arg1 withSecondaryColor:(UIColor *)arg2 {

}


-(void) addConstraintToItem:(UIView *)firstItem attribute:(NSLayoutAttribute)firstAttribute relation:(NSLayoutRelation)relation toItem:(UIView *)secondItem attribute:(NSLayoutAttribute)secondAttribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:relation toItem:secondItem attribute:secondAttribute multiplier:multiplier constant:constant]];
}
@end


@implementation BlotsView
-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.blots = [[NSMutableArray alloc] init];


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:self.isTopOrSideEnabled ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical];

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView setBackgroundColor:nil];
    [self.collectionView setClipsToBounds:NO];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView registerClass:[BlotCell class] forCellWithReuseIdentifier:@"BlotCell"];
    [self.collectionView registerClass:[DotCell class] forCellWithReuseIdentifier:@"DotCell"];
    [self addSubview:self.collectionView];

    [self addConstraintToItem:self attribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self addConstraintToItem:self attribute:NSLayoutAttributeTrailing relation:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    [self addConstraintToItem:self.collectionView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    if(!self.isTopOrSideEnabled) {
      self.height = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
      [self addConstraint:self.height];
    } else {
      self.width = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
      [self addConstraint:self.width];
    }
  } return self;
}

-(void) layoutSubviews {
  [super layoutSubviews];
  if(!self.isTopOrSideEnabled) {
    CGFloat newHeight = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    [self.height setConstant:newHeight];
    [self setNeedsUpdateConstraints];
  } else {
    CGFloat newWidth = self.collectionView.collectionViewLayout.collectionViewContentSize.width;
    [self.width setConstant:newWidth];
    [self setNeedsUpdateConstraints];
  }
}


-(void) addConstraintToItem:(UIView *)firstItem attribute:(NSLayoutAttribute)firstAttribute relation:(NSLayoutRelation)relation toItem:(UIView *)secondItem attribute:(NSLayoutAttribute)secondAttribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:relation toItem:secondItem attribute:secondAttribute multiplier:multiplier constant:constant]];
}


-(void) blot_insertIcon:(SBIcon *)arg1 {
  [self.blots addObject:arg1];
  [self reload];
}

-(void) blot_removeIcon:(SBIcon *)arg1 {
  [self.blots removeObject:arg1];
  [self reload];
}


-(void) reload {
  if(!self.isTopOrSideEnabled) {
    CGFloat newHeight = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    [self.height setConstant:newHeight];
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
  } else {
    CGFloat newWidth = self.collectionView.collectionViewLayout.collectionViewContentSize.width;
    [self.width setConstant:newWidth];
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
  }
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.blots count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BlotCell *blotCell = (BlotCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BlotCell" forIndexPath:indexPath];
  DotCell *dotCell = (DotCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DotCell" forIndexPath:indexPath];

  if(self.allowsDot) {
    //[dotCell.iconImageView setIcon:self.blots[indexPath.item] location:0 animated:NO];
    //[dotCell setIcon:self.blots[indexPath.item]];

    SBIconImageView *iconImageView = (SBIconImageView *)[[NSClassFromString(@"SBIconImageView") alloc] init];
    [iconImageView setIcon:self.blots[indexPath.item] location:0 animated:NO];
    [self setColorForColor:[self coloursForImage:iconImageView.displayedImage forEdge:2][@"primary"] withSecondaryColor:[self getAverageColor:iconImageView.displayedImage] forCell:dotCell];

    return dotCell;
  } else {
    [blotCell.iconImageView setIcon:self.blots[indexPath.item] location:0 animated:NO];
    return blotCell;
  }
}


-(void) setColorForColor:(UIColor *)arg1 withSecondaryColor:(UIColor *)arg2 forCell:(DotCell *)arg3 {
  UIColor *color1 = arg1;
  UIColor *color2 = arg2;

  CGFloat r1, r2, g1, g2, b1, b2, a1, a2;
  [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
  [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];

  UIColor *avg = [UIColor colorWithRed: (r1 + r2) / 2.0f green: (g1 + g2) / 2.0f blue: (b1 + b2) / 2.0f alpha: (a1 + a2) / 2.0f];

  dispatch_async(dispatch_get_main_queue(), ^(){
    [arg3.dotView setBackgroundColor:avg];
    [arg3.dotView startPulseWithColor:avg scaleFrom:1.0 to:2.0 frequency:1.0 opacity:0.8 animation:YGPulseViewAnimationTypeRadarPulsing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.9 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
      [arg3.dotView stopPulse];
    });
  });
}

-(UIColor *) getAverageColor:(UIImage *)image {
  CGSize size = {
    1, 1
  };

  UIGraphicsBeginImageContext(size);
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium);
  [image drawInRect:(CGRect){.size = size} blendMode:kCGBlendModeNormal alpha:1];
  uint8_t *data = CGBitmapContextGetData(ctx);

  UIColor *color = [UIColor colorWithRed:data[2] / 255.0f green:data[1] / 255.0f blue:data[0] / 255.0f alpha:1];

  UIGraphicsEndImageContext();

  return color;
}

-(NSDictionary *)coloursForImage:(UIImage *)image forEdge:(int)edge {
  float dimension = 12;

  CGImageRef imageRef = [image CGImage];
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  unsigned char *rawData = (unsigned char *) calloc(dimension * dimension * 4, sizeof(unsigned char));

  NSUInteger bytesPerPixel = 4;
  NSUInteger bytesPerRow = bytesPerPixel * dimension;
  NSUInteger bitsPerComponent = 8;

  CGContextRef context = CGBitmapContextCreate(rawData, dimension, dimension, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
  CGColorSpaceRelease(colorSpace);
  CGContextDrawImage(context, CGRectMake(0, 0, dimension, dimension), imageRef);
  CGContextRelease(context);

  NSMutableArray * colours = [NSMutableArray new];

  float x = 0, y = 0;
  float eR = 0, eB = 0, eG = 0;

  for(int n = 0; n < (dimension * dimension); n++) {
    Colour * c = [Colour new];
    int i = (bytesPerRow * y) + x * bytesPerPixel;
    c.r = rawData[i];
    c.g = rawData[i + 1];
    c.b = rawData[i + 2];
    [colours addObject:c];

    if((edge == 0 && y == 0) || /* top */ (edge == 1 && x == 0) || /* left */ (edge == 2 && y == dimension-1) || /* bottom */ (edge == 3 && x == dimension-1)) { /* right */
      eR += c.r;
      eG += c.g;
      eB += c.b;
    }

    x = (x == dimension - 1) ? 0 : x + 1;
    y = (x == 0) ? y + 1 : y;
  } free(rawData);

  Colour *e = [Colour new];
  e.r = eR / dimension;
  e.g = eG / dimension;
  e.b = eB / dimension;

  NSMutableArray * accents = [NSMutableArray new];

  float minContrast = 3.1;
  while(accents.count < 3) {
    for(Colour *a in colours) {
      if([self contrastValueFor:a andB:e] < minContrast) {
        continue;
      }

      for(Colour * b in colours) {
        a.d += [self colourDistance:a andB:b];
      } [accents addObject:a];
    } minContrast -= 0.1f;
  }

  NSArray *sorted = [[NSArray arrayWithArray:accents] sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"d" ascending:true]]];
  Colour *p = sorted[0];

  float high = 0.0f;
  int index = 0;
  for(int n = 1; n < sorted.count; n++) {
    Colour * c = sorted[n];
    float contrast = [self contrastValueFor:c andB:p];

    if(contrast > high) {
      high = contrast;
      index = n;
    }
  }

  Colour *s = sorted[index];

  NSMutableDictionary *result = [NSMutableDictionary new];
  [result setValue:[UIColor colorWithRed:e.r / 255.0f green:e.g / 255.0f blue:e.b / 255.0f alpha:1.0f] forKey:@"background"];
  [result setValue:[UIColor colorWithRed:p.r / 255.0f green:p.g / 255.0f blue:p.b / 255.0f alpha:1.0f] forKey:@"primary"];
  [result setValue:[UIColor colorWithRed:s.r / 255.0f green:s.g / 255.0f blue:s.b / 255.0f alpha:1.0f] forKey:@"secondary"];

  return result;
}

-(float) contrastValueFor:(Colour *)a andB:(Colour *)b {
  float aL = 0.2126 * a.r + 0.7152 * a.g + 0.0722 * a.b;
  float bL = 0.2126 * b.r + 0.7152 * b.g + 0.0722 * b.b;
  return (aL > bL) ? (aL + 0.05) / (bL + 0.05) : (bL + 0.05) / (aL + 0.05);
}

-(float) saturationValueFor:(Colour *)a andB:(Colour *)b {
  float min = MIN(a.r, MIN(a.g, a.b));
  float max = MAX(b.r, MAX(b.g, b.b));
  return (max - min) / max;
}

-(int) colourDistance:(Colour *)a andB:(Colour *)b {
  return abs(a.r - b.r) + abs(a.g - b.g) + abs(a.b - b.b);
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  SBApplication *app = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:[self.blots[indexPath.item] applicationBundleID]];
  if(self.isPersistantEnabled) {
    [self.blots removeObjectAtIndex:indexPath.item];
    [self reload];
    [[NSClassFromString(@"SBUIController") sharedInstance] _activateApplicationFromAccessibility:app];
  }

  if(!self.isTopOrSideEnabled) {
    CGFloat newHeight = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    [self.height setConstant:newHeight];
    [self setNeedsUpdateConstraints];
  } else {
    CGFloat newWidth = self.collectionView.collectionViewLayout.collectionViewContentSize.width;
    [self.width setConstant:newWidth];
    [self setNeedsUpdateConstraints];
  }
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.allowsDot ? CGSizeMake(self.itemSize, self.itemSize) : CGSizeMake(self.itemSize + 2, self.itemSize + 2);
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 8;
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 8;
}
@end
