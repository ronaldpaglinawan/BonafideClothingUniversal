//
//  SideBarTableViewController.m
//  BonafideClothing
//
//  Created by Pauline Milan on 7/15/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "SideBarTableViewController.h"
#import "SWRevealViewController.h"
#import "SideBarWebViewController.h"


@interface SideBarTableViewController ()

@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation SideBarTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.5f alpha:.5f];
    
    _menuItems = @[@"TITLE", @"HOME", @"NEW ARRIVALS", @"BRANDS", @"MENS", @"COLLECTIONS", @"CART", @"STORE LOCATOR", @"OFFICIAL WEBSITE"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [_menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    /*
    // Set the url if it navigates to the SideBarWebViewController
    if ([segue.identifier isEqualToString:@"showPhoto"])
    {
        SideBarWebViewController *webController = (SideBarWebViewController*)segue.destinationViewController;
        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo.jpg", [_menuItems objectAtIndex:indexPath.row]];
        //webController.photoFilename = photoFilename;
    }
    */
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
    
    // trial
    if ([segue.identifier isEqualToString:@"showNewArrivalsPage"])
    {
        // Open sideBarWebSiteViewController:
        SideBarWebViewController *webPage = [segue destinationViewController];
        
        [webPage setSideBarWebString:@"http://bnfde.com/collections/new-arrivals?"];
        
    }
    
    else if ([segue.identifier isEqualToString:@"showBrandsPage"])
    {
        // Open sideBarWebSiteViewController:
        SideBarWebViewController *webPage = [segue destinationViewController];
        
        [webPage setSideBarWebString:@"http://bnfde.com/pages/brand-portfolio?"];
        
    }
    
    else if ([segue.identifier isEqualToString:@"showMensPage"])
    {
        // Open sideBarWebSiteViewController:
        SideBarWebViewController *webPage = [segue destinationViewController];
        
        [webPage setSideBarWebString:@"http://bnfde.com/collections/all-product?"];
        
    }
    
    else if ([segue.identifier isEqualToString:@"showCollectionsPage"])
    {
        // Open sideBarWebSiteViewController:
        SideBarWebViewController *webPage = [segue destinationViewController];
        
        [webPage setSideBarWebString:@"http://bnfde.com/pages/bnfde-collection?"];
        
    }
    
    else if ([segue.identifier isEqualToString:@"showCartPage"])
    {
        // Open sideBarWebSiteViewController:
        SideBarWebViewController *webPage = [segue destinationViewController];
        
        [webPage setSideBarWebString:@"http://bnfde.com/cart"];
        
    }

    
    else if ([segue.identifier isEqualToString:@"showOfficialWebPage"])
    {
        // Open sideBarWebSiteViewController:
        SideBarWebViewController *webPage = [segue destinationViewController];
        
        [webPage setSideBarWebString:@"http://bnfde.com?"];
        
    }
    
    else
    {
        // Unknown status. Do nothing
    }
    
}


@end
