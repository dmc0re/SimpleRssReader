#import "MainViewController.h"
#import "FeedItemController.h"
#import "WebViewController.h"
#import "TableViewCell.h"

@interface MainViewController ()

@property (weak, nonatomic) UITextField *urlTextField;
@property (weak, nonatomic) UITextField *filterTextField;
@property (weak, nonatomic) UITableView *tableView;

@property(nonatomic, strong)FeedItemController * feedItemController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _feedItemController = [FeedItemController new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //    if ([self.view window] == nil)
    //        self.view = nil;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITextField *urlTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 72, 150, 30)];
    [urlTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [urlTextField setPlaceholder:@"RSS feed"];
    [urlTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [urlTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [urlTextField setKeyboardType:UIKeyboardTypeURL];
    [urlTextField setReturnKeyType:UIReturnKeyGo];
    [urlTextField addTarget:self action:@selector(onUrlTextFieldEditingEnd) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self setUrlTextField:urlTextField];
    
    UITextField *filterTextField = [[UITextField alloc]initWithFrame:CGRectMake(160, 72, 150, 30)];
    [filterTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [filterTextField setPlaceholder:@"filter..."];
    [filterTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [filterTextField addTarget:self action:@selector(onFilterTextFieldEditingEnd) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self setFilterTextField:filterTextField];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 105, 300, 400)];
    [tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [tableView setRowHeight:90];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self setTableView:tableView];
    
    
    [self.view addSubview:urlTextField];
    [self.view addSubview:filterTextField];
    [self.view addSubview:tableView];
    
    id bottom = self.bottomLayoutGuide;
    id top = self.topLayoutGuide;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(urlTextField, filterTextField, tableView, bottom, top);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[urlTextField]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top]-[filterTextField]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[urlTextField]-[filterTextField]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[urlTextField(==filterTextField)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[filterTextField]-[tableView]-[bottom]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:views]];
    
    [self.view layoutSubviews];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_feedItemController feedItemCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseId = @"TableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    if (cell == nil)
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseId];
    
    FeedItem *item = [_feedItemController feedItemAtIndex:indexPath.row];
    
    cell.titleLabel.text = [item title];
    cell.descriptionLabel.text = [item body];
    cell.thumbnailView.image = [item image];
    cell.dateLabel.text = [item date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *webViewController = [WebViewController new];
    
    FeedItem *feedItem =[_feedItemController feedItemAtIndex:[indexPath row]];
    [webViewController setFeedItem:feedItem];
    
    [[self navigationController] pushViewController:webViewController animated:YES];
}

- (void)onUrlTextFieldEditingEnd
{
    NSString *url = [_urlTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [_feedItemController parseXMLFileAtUrl:url];
    [_tableView reloadData];
}

- (void)onFilterTextFieldEditingEnd
{
    [_feedItemController filterByValue:_filterTextField.text];
    [_tableView reloadData];
}

@end
