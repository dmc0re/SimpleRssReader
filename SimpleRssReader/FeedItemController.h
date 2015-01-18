#import <Foundation/Foundation.h>
#import "FeedItem.h"


@interface FeedItemController : NSObject<NSXMLParserDelegate>

@property(nonatomic, readonly)NSArray *feedItemList;

- (void)parseXMLFileAtUrl:(NSString *)URL;
- (void)filterByValue:(NSString *)value;
- (NSUInteger)feedItemCount;
- (FeedItem *)feedItemAtIndex:(NSUInteger)index;

@end
