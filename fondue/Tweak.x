#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Headers.h"
#import "Classes/FondueBannerWindow.h"


@interface NSUserDefaults (Fondue)
-(id) objectForKey:(NSString *)key inDomain:(NSString *)domain;
-(void) setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString *domain = @"com.antique.fondue_prefs";
static NSString *notification = @"com.antique.fondue_prefs/changed";
static NSInteger bannerType;
static BOOL enabled;


FondueBannerWindow *fondueBannerWindow;
%hook SpringBoard
-(void) applicationDidFinishLaunching:(id)arg1 {
  %orig;

  fondueBannerWindow = [[FondueBannerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [fondueBannerWindow setHidden:NO];
  [fondueBannerWindow setWindowLevel:1100]; // 1090 is the default banner windowLevel, we use 1100 to go above that.

  if(enabled) {
    [self showFondueWindow]; // iOS 13 and above hack to show our window, makeKeyAndVisible ain't worth shit now.
  }
}


%new // USE %NEW WHEN USING UNORIGINAL METHODS
-(void) showFondueWindow {
  if(@available(iOS 13.0, *)) {
    if(!fondueBannerWindow.windowScene || fondueBannerWindow.windowScene.activationState != UISceneActivationStateForegroundActive) {
      for(UIScene *scene in [[UIApplication sharedApplication] connectedScenes]) {
        if(scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
          [fondueBannerWindow setWindowScene:(UIWindowScene *)scene];
          break;
        }
      }
    }
  } else {
    // makeKeyAndVisible would probably work here, not gonna use it in my tweak though
  }
}
%end


%hook NCNotificationStructuredListViewController
-(void) insertNotificationRequest:(NCNotificationRequest *)arg1 {
  %orig;

  if(enabled) {
    if(bannerType == 0) {
      [fondueBannerWindow presentSmallBannerWithRequest:arg1];
    } else {
      [fondueBannerWindow presentFullScreenBannerWithRequest:arg1];
    }
  }
}
%end


%hook SBBannerWindow
-(id) init {
  return enabled ? nil : %orig;
}
%end


static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  NSNumber *bannerValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"bannerType" inDomain:domain];
	NSNumber *enabledValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:domain];

	bannerType = (bannerValue) ? [bannerValue integerValue] : 0;
  enabled = (enabledValue) ? [enabledValue boolValue] : YES;
}

%ctor {
	notificationCallback(NULL, NULL, NULL, NULL, NULL);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)notification, NULL, CFNotificationSuspensionBehaviorCoalesce);
}
