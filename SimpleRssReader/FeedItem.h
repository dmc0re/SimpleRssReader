#import <Foundation/Foundation.h>

@class UIImage;

@interface FeedItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *origBody;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *date;

@end
