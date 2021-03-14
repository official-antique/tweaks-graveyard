#include "FUIRootListController.h"


@implementation FUIRootListController
-(NSArray *) specifiers {
  if(!_specifiers) {
    _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
  } return _specifiers;
}
@end
