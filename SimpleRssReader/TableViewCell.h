
#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *descriptionLabel;
@property (weak, nonatomic) UILabel *dateLabel;
@property (weak, nonatomic) UIImageView *thumbnailView;

@end
