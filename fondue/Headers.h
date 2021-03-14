#import <UIKit/UIKit.h>


@interface UIImage (Private)
+(UIImage *)_applicationIconImageForBundleIdentifier:(NSString *)arg1 format:(int)arg2 scale:(double)arg3;
@end


@interface BBBulletin : NSObject
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *section;
@property (nonatomic, copy) NSString *title;

@end


@interface NCNotificationRequest : NSObject
@property (nonatomic, readonly) BBBulletin *bulletin;
@end

@interface NCNotificationStructuredListViewController : UIViewController
-(void) insertNotificationRequest:(NCNotificationRequest *)arg1;
-(void) removeNotificationRequest:(NCNotificationRequest *)arg1;
@end


@interface SBBannerWindow : UIWindow
@end


@interface SpringBoard : UIApplication
-(void) showFondueWindow;
@end
