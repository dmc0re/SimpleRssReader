#import <Foundation/Foundation.h>

@class UIImage;

@interface FeedItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) UIImage  *image;
@property (nonatomic, strong) NSString *date;

@end
