//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Julio Reyes on 10/22/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "qcdDemoViewController.h"
#import "ChildViewController.h"

@interface qcdDemoViewController ()
@property qcdDAO *dataAccessObject;
@end

@implementation qcdDemoViewController

static NSString *CellIdentifier = @"Cell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Set up Data Access
    self.companyList = [[NSMutableArray alloc]init];
    
    _dataAccessObject = [qcdDAO sharedInstance];
    [_dataAccessObject initCurrentDefaults];
    
    if(![_dataAccessObject.currentDefaults boolForKey:@"firstRun"]) {
        [_dataAccessObject initWithCompaniesAndProducts];
        [_dataAccessObject addProductsToCompanies];

        self.companyList = [_dataAccessObject GetCompanies];
        [_dataAccessObject saveCompanies:self.companyList];
        
        [_dataAccessObject.currentDefaults setBool:YES forKey:@"firstRun"];
    }else{
        self.companyList =  [_dataAccessObject GetCompanies];
    }

    self.title = @"Mobile device makers";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Company *currentCompany = [self.companyList objectAtIndex:indexPath.row];
    
    NSString *companyName = currentCompany.CompanyName;
    NSString *companyImage = currentCompany.CompanyImage;
    
    cell.textLabel.text = companyName;
    cell.imageView.image = [UIImage imageNamed:companyImage];
    
    NSLog(@"Company %@, ID: %ld", companyName, (long)currentCompany.CompanyID);
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [_dataAccessObject saveCompanies:self.companyList];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
 // Return NO if you do not want the item to @property (assign) NSInteger *currentIndex;
be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company *pickedCompany = [self.companyList objectAtIndex:indexPath.row];
    
    self.childVC.title = pickedCompany.CompanyName;
    self.childVC.selectedCompany = pickedCompany;
    self.childVC.currentIndex = indexPath.row;
   
    NSLog(@"%@", self.childVC.selectedCompany.CompanyProducts);

    [self.navigationController pushViewController:self.childVC animated:YES];
}
 


@end
