//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Julio Reyes on 10/22/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "qcdDemoViewController.h"
#import "ChildViewController.h"
#import "qcdDemoCollectionViewCell.h"

@interface qcdDemoViewController ()<UIGestureRecognizerDelegate, UIAlertViewDelegate>
@property qcdDAO *dataAccessObject;
@property (retain, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation qcdDemoViewController
int selectedIndex;
static NSString *CellIdentifier = @"QCDCell";

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
    //self.clearsSelectionOnViewWillAppear = NO;
    qcdDemoAppDelegate *appDelegate = APPDELEGATE;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(DeleteCell:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];

    // Set up Data Access
    NSMutableArray *comapnyArray = [[NSMutableArray alloc]init];
    self.companyList = comapnyArray;
    [comapnyArray release];
//    
    _dataAccessObject = [qcdDAO sharedInstance];
   [_dataAccessObject initCurrentDefaults];
    
    if(![_dataAccessObject.currentDefaults boolForKey:@"firstRun"]) {
        [_dataAccessObject initWithCompaniesAndProducts];
        [_dataAccessObject addProductsToCompanies];

        self.companyList = [_dataAccessObject GetCompanies];
        [appDelegate saveContext];
        
        [_dataAccessObject.currentDefaults setBool:YES forKey:@"firstRun"];
    }else{
        [self handleCoreData];
    }

    self.title = @"Mobile device makers";
    
    UINib *cellNib = [UINib nibWithNibName:@"qcdDemoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:CellIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(250, 250)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    [flowLayout release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)handleCoreData{
    qcdDemoAppDelegate *appDelegate = APPDELEGATE;

    NSArray *cdCompArray = [appDelegate getCompaniesUsingCoreData];
    NSArray *cdProArray = [appDelegate getProductsUsingCoreData];
    
    NSMutableArray *productList = [[NSMutableArray alloc]init];
    for (Product *p in cdProArray) {
        NeueProduct *viewProduct = [[NeueProduct alloc]initWithID:[p.productid integerValue]  ProductName:p.productname ProductReference:p.reference CompanyID:[p.companyid integerValue]];
        [productList addObject:viewProduct];
        [viewProduct release];
    }
    
    for (Company *c in cdCompArray) {
        
        NeueCompany *viewCompany = [[NeueCompany alloc]initWithCompanyID:[c.id integerValue] CompanyName:c.name CompanyProducts:[NSMutableArray array] CompanyImage:c.image];
        [self.companyList addObject:viewCompany];
        [viewCompany release];

    }
    
    for (NeueProduct* product in productList) {
        for (NeueCompany* company in self.companyList) {
            if (company.CompanyID == product.CompanyID) {
                [company.CompanyProducts addObject:product];
            }
        }
    }
    
    [productList release];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.companyList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{


    qcdDemoCollectionViewCell *cell = (qcdDemoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  
    // Configure the cell...
    NeueCompany *currentCompany = [self.companyList objectAtIndex:indexPath.row];
    
    NSString *companyName = currentCompany.CompanyName;
    NSString *companyImage = currentCompany.CompanyImage;
    
    cell.cellName.text = companyName;
    cell.cellImageView.image = [UIImage imageNamed:companyImage];
    
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
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [self.companyList removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        [_dataAccessObject saveCompanies:self.companyList];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


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

-(void)rearrangeCells{
    [self.collectionView performBatchUpdates:^{
        for (NSInteger i = 0; i < self.companyList.count; i++) {
            NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSInteger j = [self.companyList indexOfObject:self.companyList[i]];
            NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:j inSection:0];
            [self.collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        }
    } completion:^(BOOL finished) {}];
}
#pragma mark - Remove COLLECTION
- (void)DeleteCell:(UILongPressGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really Delete?" message:@"Do you really want to remove this company?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gr locationInView:self.collectionView]];
        selectedIndex = (int)indexPath.row;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self removeCell:selectedIndex];
    }
}

-(void)removeCell:(int) i {
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:i inSection:0];
    qcdDemoAppDelegate *appDelegate = APPDELEGATE;

    [self.collectionView performBatchUpdates:^{
        
        [appDelegate DeleteObjectUsingCoreData:[self.companyList objectAtIndex:indexPath.row]];
         
        [self.companyList removeObjectAtIndex:indexPath.row];
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
}


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NeueCompany *pickedCompany = [self.companyList objectAtIndex:indexPath.row];
    
    self.childVC.title = pickedCompany.CompanyName;
    self.childVC.selectedCompany = pickedCompany;
    self.childVC.currentIndex = indexPath.row;
   
    NSLog(@"%@", self.childVC.selectedCompany.CompanyProducts);
    
    [self.navigationController pushViewController:self.childVC animated:YES];
}

- (void)dealloc {
    [_companyList release];
    _companyList = nil;
    [_collectionView release];
    [_companyList release];
    [super dealloc];
}
@end
