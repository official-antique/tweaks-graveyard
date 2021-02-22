#import <UIKit/UIKit.h>

%hook UITableView
-(id) initWithFrame:(CGRect)arg1 style:(UITableViewStyle)arg2 {
  return arg2 == UITableViewStyleGrouped ? %orig(arg1, UITableViewStyleInsetGrouped) : %orig(arg1, arg2);
}
%end
