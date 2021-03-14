@interface HitTestWindow : UIWindow
@end




@interface SBIcon : NSObject
@property (readonly, copy, nonatomic) NSString *displayName;
@property (readonly, nonatomic) double progressPercent;

-(NSString *) applicationBundleID;
-(id) badgeNumberOrString; // ?
-(long long) badgeValue;

-(void) setBadge:(id)arg1; // ?
@end

@interface SBApplication : NSObject
@property (readonly, nonatomic, getter=isInternalApplication) BOOL internalApplication;
@property (nonatomic, getter=isPlayingAudio) BOOL playingAudio;
@property (readonly, nonatomic, getter=isSystemApplication) BOOL systemApplication;
@property (readonly, nonatomic, getter=isUninstallSupported) BOOL uninstallSupported;

-(BOOL)_isNewlyInstalled;
-(BOOL)_isRecentlyUpdated;

-(BOOL) iconSupportsUninstall:(SBIcon *)arg1;
@end

@interface SBApplicationController : NSObject
+(SBApplicationController *) sharedInstance;

-(SBApplication *) applicationWithBundleIdentifier:(NSString *)arg1;
-(NSArray <SBApplication *> *) runningApplications;
@end

@interface SBIconModel : NSObject
-(SBIcon *) expectedIconForDisplayIdentifier:(NSString *)identifier;
@end

@interface SBIconController : UIViewController
+(SBIconController *) sharedInstance;

@property (readonly, copy, nonatomic) NSArray <SBApplication *> *allApplications;
@property (retain, nonatomic) SBIconModel *model;
@end

@interface SBHIconImageCache : NSObject
-(id) imageForIcon:(id)arg1; // ?
@end

@interface SBIconImageView : UIView
@property (readonly, nonatomic) UIImage *displayedImage;
@property (retain, nonatomic) SBHIconImageCache *iconImageCache;

-(void) setIcon:(SBIcon *)arg1 location:(long long)arg2 animated:(BOOL)arg3;
@end

@interface SBIconListView : UIView
@end

@interface SBIconView : UIView
@property (nonatomic, retain) id delegate; // ?
@property (nonatomic, retain) SBIcon *icon;
@property (nonatomic, getter=isInDock) BOOL inDock;

-(void)_setIcon:(SBIcon *)icon animated:(BOOL)animated;
-(void)_updateAccessoryViewWithAnimation:(BOOL)arg1;
@end

@interface SBUIController : NSObject
+(SBUIController *) sharedInstance;

-(void)_activateApplicationFromAccessibility:(id)arg1; // ?
@end

@interface SBUILegibilityLabel : UIView
@property (nonatomic,copy) NSString *string;
@end


@interface SpringBoard : UIApplication
@property (nonatomic, strong) HitTestWindow *hitWindow;

-(void) addConstraintToItem:(UIView *)firstItem attribute:(NSLayoutAttribute)firstAttribute relation:(NSLayoutRelation)relation toItem:(UIView *)secondItem attribute:(NSLayoutAttribute)secondAttribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant;
-(void) showBlot;
@end


@interface NCNotificationRequest : NSObject
@property (readonly, copy, nonatomic) NSString *categoryIdentifier;
@property (readonly, copy, nonatomic) NSString *notificationIdentifier;
@property (readonly, copy, nonatomic) NSString *sectionIdentifier;
@property (readonly, copy, nonatomic) NSString *threadIdentifier;
@end

@interface NCNotificationStructuredListViewController : UIViewController
-(UIColor *) getAverageColor:(UIImage *)arg1;
@end

@interface NCNotificationListSectionRevealHintView : UIView
@property(retain, nonatomic) SBUILegibilityLabel *revealHintTitle;
@end


@interface _UIBackdropViewSettings : NSObject
+(_UIBackdropViewSettings *) settingsForStyle:(int)arg1;
@end

@interface _UIBackdropView : UIView
-(_UIBackdropView *) initWithFrame:(CGRect)arg1 autosizesToFitSuperview:(BOOL)arg2 settings:(_UIBackdropViewSettings *)arg3;
-(_UIBackdropView *) initWithPrivateStyle:(int)arg1;
-(_UIBackdropView *) initWithSettings:(_UIBackdropViewSettings *)arg1;
-(_UIBackdropView *) initWithStyle:(int)arg1;

-(void) setBlursBackground:(BOOL)arg1;
-(void) setBlurFilterWithRadius:(float)arg1 blurQuality:(NSString *)arg2;
-(void) setBlurFilterWithRadius:(float)arg1 blurQuality:(NSString *)arg2 blurHardEdges:(int)arg3;
-(void) setBlurHardEdges:(int)arg1;
-(void) setBlurQuality:(NSString *)arg1;
-(void) setBlurRadius:(float)arg1;
-(void) setBlurRadiusSetOnce:(BOOL)arg1;
-(void) setBlursWithHardEdges:(BOOL)arg1;
@end


@interface _LSDiskUsage : NSObject
@property (nonatomic, readonly) NSNumber *dynamicUsage;
@end

@interface _LSLazyPropertyList : NSObject
@property (readonly) NSDictionary *propertyList;
@end

@interface LSBundleProxy : NSObject
@property (nonatomic, readonly) NSString *localizedShortName;
@end

@interface LSApplicationProxy : NSObject
@property (setter=_setInfoDictionary:, nonatomic, copy) _LSLazyPropertyList *_infoDictionary;

@property (nonatomic, readonly) NSArray *appTags;
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) _LSDiskUsage *diskUsage;
@property (nonatomic, readonly) NSString *genre;
@property (nonatomic, readonly) NSDictionary *iconsDictionary;
@property (setter=_setLocalizedName:, nonatomic, copy) NSString *localizedName;
@property (nonatomic, readonly) NSString *primaryIconName;
@property (nonatomic, readonly) NSString *shortVersionString;

-(NSArray <NSString *> *)_boundIconFileNames;

-(NSArray <NSString *> *) boundIconFileNames;
@end

@interface LSApplicationWorkspace
+(LSApplicationWorkspace *) defaultWorkspace;

-(id) allApplications; // ?
-(id) allInstalledApplications; // ?
-(id) applicationsOfType:(unsigned long long)arg1; // ?
-(id) applicationsWithUIBackgroundModes; // ?
-(BOOL) openApplicationWithBundleID:(NSString *)arg1;
@end


@interface Colour : NSObject
@property int r, g, b, a;
@end

@interface UIView (Rounded)
-(void) createMaskWithCornerRadius:(CGFloat)radius;
@end


@interface BlotCell : UICollectionViewCell
@property (nonatomic, strong) SBIconImageView *iconImageView;
@end

@interface DotCell : UICollectionViewCell
@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) SBIcon *icon;
@property (nonatomic, strong) SBIconImageView *iconImageView;

-(void) setColorForColor:(UIColor *)arg1 withSecondaryColor:(UIColor *)arg2;
@end


@interface BlotsView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) BOOL allowsDot;
@property (nonatomic, strong) NSMutableArray *blots;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSLayoutConstraint *height;
@property (nonatomic, strong) NSLayoutConstraint *width;
@property (nonatomic, assign) BOOL isPersistantEnabled;
@property (nonatomic, assign) BOOL isTopOrSideEnabled;
@property (nonatomic) NSInteger itemSize;


-(void) blot_insertIcon:(SBIcon *)arg1;
-(void) blot_removeIcon:(SBIcon *)arg1;

-(void) setColorForColor:(UIColor *)arg1 withSecondaryColor:(UIColor *)arg2 forCell:(DotCell *)arg3;
@end
