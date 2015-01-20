#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView *thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 60, 60)];
        [thumbnailView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [thumbnailView setContentMode:UIViewContentModeScaleAspectFit];
        [self setThumbnailView:thumbnailView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 3, 214, 40)];
        [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.numberOfLines = 2;
        [self setTitleLabel:titleLabel];
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 35, 204, 34)];
        [descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        descriptionLabel.font = [UIFont systemFontOfSize:10];
        descriptionLabel.numberOfLines = 2;
        [self setDescriptionLabel:descriptionLabel];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 67, 280, 20)];
        [dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        dateLabel.font = [UIFont systemFontOfSize:8];
        [self setDateLabel:dateLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self.contentView addSubview:thumbnailView];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:descriptionLabel];
        [self.contentView addSubview:dateLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(thumbnailView, titleLabel, descriptionLabel, dateLabel);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[thumbnailView(==60)]-[titleLabel]-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[thumbnailView(==60)]-[descriptionLabel]-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel][descriptionLabel]" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[thumbnailView(==60)]-3-[dateLabel]" options:0 metrics:nil views:views]];
         [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dateLabel]" options:0 metrics:nil views:views]];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end