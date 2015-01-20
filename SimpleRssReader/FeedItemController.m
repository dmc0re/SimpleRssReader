#import <UIKit/UIKit.h>
#import "FeedItemController.h"

@interface FeedItemController ()
{
    NSMutableArray      *beginFeedItemList;
    
    FeedItem            *feedItem;
    NSMutableString     *tagValue;
}

@end

@implementation FeedItemController

- (NSUInteger)feedItemCount
{
    return [_feedItemList count];
}

- (FeedItem *)feedItemAtIndex:(NSUInteger)index
{
    return [_feedItemList objectAtIndex:index];
}

- (void)parseXMLFileAtUrl:(NSString *)URL
{
    if (beginFeedItemList)
        [beginFeedItemList removeAllObjects];
    else
        beginFeedItemList = [NSMutableArray new];
    
    if (![URL hasPrefix:@"http://"] && ![URL hasPrefix:@"https://"])
        URL = [NSString stringWithFormat:@"http://%@", URL];
    
    NSData *xml = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
    
    if (xml)
    {
        NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:xml];
        [rssParser setDelegate:self];
        
        [rssParser parse];
    }
}

- (void)filterByValue:(NSString *)value
{
    NSString *str = [NSString stringWithFormat:@"(title LIKE[cd] '*%@*') OR (body LIKE[cd] '*%@*')", value, value];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    _feedItemList = [beginFeedItemList filteredArrayUsingPredicate:predicate];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"item"])
        feedItem = [FeedItem new];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        [beginFeedItemList addObject:feedItem];
        feedItem = nil;
    }
    else if ([elementName isEqualToString:@"title"])
        [feedItem setTitle:[tagValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    else if ([elementName isEqualToString:@"pubDate"])
        [feedItem setDate:[tagValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    else if ([elementName isEqualToString:@"description"])
    {
        NSString *str = [tagValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"src=\"[htps:]*(//[^\"]*)" options:NSRegularExpressionCaseInsensitive error:nil];
        NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
        
        if (match)
        {
            NSString *URL = [@"http:" stringByAppendingString:[str substringWithRange:[match rangeAtIndex:1]]];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
            
            [feedItem setImage:[UIImage imageWithData:imageData]];
        }
        
        [feedItem setOrigBody:str];
        
        NSString *s = [str copy];
        NSRange range;
        while ((range = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            s = [s stringByReplacingCharactersInRange:range withString:@""];
    
        s = [s stringByReplacingOccurrencesOfString:@"&amp;" withString: @"&"];
        s = [s stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        s = [s stringByReplacingOccurrencesOfString:@"&#27;" withString:@"'"];
        s = [s stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
        s = [s stringByReplacingOccurrencesOfString:@"&#92;" withString:@"'"];
        s = [s stringByReplacingOccurrencesOfString:@"&#96;" withString:@"'"];
        s = [s stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        s = [s stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        
        [feedItem setBody: s];
    }
    
    tagValue = [NSMutableString new];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [tagValue appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    _feedItemList = beginFeedItemList;
}


@end
