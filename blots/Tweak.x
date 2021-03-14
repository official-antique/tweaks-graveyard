#import "Classes/BlotsView.h"

BOOL isDotsEnabled, isEnabled, isPersistantEnabled, isRemoveNotificationsEnabled, isTopOrSideEnabled;
NSInteger verticalAlignment, itemSize;


static void reloadPrefs() {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.antique.blots.plist"]];
    isEnabled = [[defaults objectForKey:@"isEnabled"] boolValue];
    verticalAlignment = [[defaults objectForKey:@"verticalAlignment"] integerValue];
    itemSize = [[defaults objectForKey:@"itemSize"] integerValue];
    isDotsEnabled = [[defaults objectForKey:@"isDotsEnabled"] boolValue];
    isPersistantEnabled = [[defaults objectForKey:@"isPersistantEnabled"] boolValue];

    isRemoveNotificationsEnabled = [[defaults objectForKey:@"isRemoveNotificationsEnabled"] boolValue];
    isTopOrSideEnabled = [[defaults objectForKey:@"isTopOrSideEnabled"] boolValue];
}


BlotsView *blotView;
@implementation HitTestWindow
-(id) initWithFrame:(CGRect)frame {
  if(self = [super initWithFrame:frame]) {

    blotView = [[BlotsView alloc] init];
    blotView.allowsDot = isDotsEnabled;
    blotView.itemSize = itemSize;
    blotView.isPersistantEnabled = isPersistantEnabled;
    blotView.isTopOrSideEnabled = isTopOrSideEnabled;
    [self addSubview:blotView];

    UIStatusBarManager *manager = [UIApplication sharedApplication].windows[0].windowScene.statusBarManager;
    CGRect oldRect = CGRectMake(0, manager.statusBarFrame.size.height, [[UIScreen mainScreen] bounds].size.width, isDotsEnabled ? itemSize : itemSize+2);
    //CGRect oldRect = CGRectMake(10, manager.statusBarFrame.size.height, isDotsEnabled ? itemSize : itemSize+2, [[UIScreen mainScreen] bounds].size.height - manager.statusBarFrame.size.height);
    oldRect.origin.x += verticalAlignment;


    if(isTopOrSideEnabled) {
      [self addConstraintToItem:self attribute:NSLayoutAttributeCenterY relation:NSLayoutRelationEqual toItem:blotView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
      [self addConstraintToItem:self attribute:NSLayoutAttributeLeading relation:NSLayoutRelationEqual toItem:blotView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-10];
      [self addConstraintToItem:blotView attribute:NSLayoutAttributeWidth relation:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:isDotsEnabled ? itemSize : itemSize+2];
    } else {
      [self addConstraintToItem:self attribute:NSLayoutAttributeTop relation:NSLayoutRelationEqual toItem:blotView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-oldRect.origin.y];
      [self addConstraintToItem:self attribute:NSLayoutAttributeCenterX relation:NSLayoutRelationEqual toItem:blotView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
      [self addConstraintToItem:blotView attribute:NSLayoutAttributeHeight relation:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:isDotsEnabled ? itemSize : itemSize+2];
    }
  } return self;
}


-(void) addConstraintToItem:(UIView *)firstItem attribute:(NSLayoutAttribute)firstAttribute relation:(NSLayoutRelation)relation toItem:(UIView *)secondItem attribute:(NSLayoutAttribute)secondAttribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:relation toItem:secondItem attribute:secondAttribute multiplier:multiplier constant:constant]];
}


-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self) return nil;
    else return hitView;
}
@end


%hook NCNotificationListSectionRevealHintView
-(void) layoutSubviews {
  if(isRemoveNotificationsEnabled) {
    if([self.revealHintTitle.string isEqualToString:@"No Older Notifications"]) {
      [self.revealHintTitle setString:@""];
    }
  } else {
    %orig;
  }
}
%end


%hook SpringBoard
%property (nonatomic, strong) HitTestWindow *hitWindow;
-(void) applicationDidFinishLaunching:(UIApplication *)arg1 {
    %orig;
    reloadPrefs();

    if(isEnabled) {
      self.hitWindow = [[HitTestWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
      [self.hitWindow setWindowLevel:UIWindowLevelAlert];
      [self showBlot];
    }
}


%new
-(void) showBlot {
  if(@available(iOS 13, *)) {
    self.hitWindow.hidden = NO;
    if(!self.hitWindow.windowScene || self.hitWindow.windowScene.activationState != UISceneActivationStateForegroundActive) {
      for(UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if(scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
          self.hitWindow.windowScene = (UIWindowScene *)scene;
          break;
        }
      }
    }
  } else {
    self.hitWindow.hidden = NO;
    [self.hitWindow makeKeyAndVisible];
  }
}
%end


%hook NCNotificationStructuredListViewController
-(void) removeNotificationRequest:(NCNotificationRequest *)arg1 {
  SBIconModel *model = ((SBIconController *)[NSClassFromString(@"SBIconController") sharedInstance]).model;
  SBIcon *icon = [model expectedIconForDisplayIdentifier:arg1.sectionIdentifier];

  if(icon && [blotView.blots containsObject:icon] && !isPersistantEnabled) {
    [blotView blot_removeIcon:icon];
  }
}

-(void) insertNotificationRequest:(NCNotificationRequest *)arg1 {
  SBIconModel *model = ((SBIconController *)[NSClassFromString(@"SBIconController") sharedInstance]).model;
  SBIcon *icon = [model expectedIconForDisplayIdentifier:arg1.sectionIdentifier];

  if(icon && ![blotView.blots containsObject:icon]) {
    [blotView blot_insertIcon:icon];
  }
}
%end
