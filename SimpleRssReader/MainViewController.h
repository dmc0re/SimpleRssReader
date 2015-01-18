#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (void)onUrlTextFieldEditingEnd;
- (void)onFilterTextFieldEditingEnd;

@end
