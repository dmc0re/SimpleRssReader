#import <Foundation/Foundation.h>

@class UIImage;

@interface FeedItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *origBody;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *date;

- (UIImage *)image;
@end
