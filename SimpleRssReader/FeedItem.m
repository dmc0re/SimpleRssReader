#import "FeedItem.h"

@implementation FeedItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title = @"";
        self.origBody = @"";
        self.body = @"";
        self.date = @"";
    }
    return self;
}

@end
