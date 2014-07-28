//
//  MasterViewController.m
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/19/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController ()
{
    NSMutableArray *_objects;
    NSString *itemName;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createMemberData];
    
    // set the navigation bar properties
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_image"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    // set the status bar to light color
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // set tableView's alpha
    self.tableView.alpha = 0.88;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createMemberData
{
    
	NSMutableArray *sideBarItems;
	
	sideBarItems = [[NSMutableArray alloc] init];
    
	
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"HOME", @"name",
                             @"home", @"picture", @"http://bnfde.com?", @"url", nil]];
    
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"NEW ARRIVALS", @"name",
                            @"star", @"picture", @"http://bnfde.com/collections/new-arrivals?", @"url", nil]];
    
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"BRANDS", @"name",
                            @"tag", @"picture", @"http://bnfde.com/pages/brand-portfolio?", @"url", nil]];
    
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"MENS", @"name",
                            @"briefcase", @"picture", @"http://bnfde.com/collections/all-product?", @"url", nil]];
    
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"COLLECTIONS", @"name",
                            @"present", @"picture", @"http://bnfde.com/pages/bnfde-collection?", @"url", nil]];
    
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"CART", @"name",
                            @"cart", @"picture", @"http://bnfde.com/cart", @"url", nil]];
    
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"STORE LOCATOR", @"name",
                            @"pin", @"picture", @"http://bnfde.com?", @"url", nil]];
    
    [sideBarItems addObject:[[NSDictionary alloc]
                            initWithObjectsAndKeys:@"OFFICIAL WEBSITE", @"name",
                            @"world", @"picture", @"http://bnfde.com?", @"url", nil]];
    
    
	self.memberData = @[sideBarItems];
    
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.memberData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideBarCell" forIndexPath:indexPath];

    cell.textLabel.text=[[[self.memberData objectAtIndex:indexPath.section]
                          objectAtIndex: indexPath.row] objectForKey:@"name"];
    
    UIImage *memberImage;
    memberImage = [UIImage imageNamed:
                  [[[self.memberData objectAtIndex:indexPath.section] objectAtIndex: indexPath.row] objectForKey:@"picture"]];
    
    cell.imageView.image = memberImage;
    
    cell.contentView.backgroundColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.detailViewController.detailItem = [[_memberData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    
    // set the itemName to chosen item name in sidebar
    itemName = [[[self.memberData objectAtIndex:indexPath.section] objectAtIndex: indexPath.row] objectForKey:@"name"];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    
    
    else if ([[segue identifier] isEqualToString:@"showDetail"] && [itemName isEqualToString:@"STORE LOCATOR"])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    
}

@end
