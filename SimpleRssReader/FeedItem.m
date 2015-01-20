#import "FeedItem.h"
#import <UIKit/UIKit.h>

@interface FeedItem()
{
    UIImage *img;
}

@end

@implementation FeedItem

- (UIImage *)image
{
    if (img == nil)
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]];
        img = [UIImage imageWithData:imageData];
    }
    return img;
}

@end
