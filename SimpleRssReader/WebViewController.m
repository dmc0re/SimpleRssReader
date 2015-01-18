
#import "WebViewController.h"
#import "FeedItem.h"

@interface WebViewController ()

@property (weak, nonatomic) UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *page = [NSString stringWithFormat:@"%@<br><br>%@<br><br>%@", [_feedItem title], [_feedItem date], [_feedItem body]];
    [_webView loadHTMLString:page baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIWebView *webView = [UIWebView new];
    [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setWebView:webView];
    
    [self.view addSubview:webView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(webView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[webView]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[webView]-|" options:0 metrics:nil views:views]];
}

@end
