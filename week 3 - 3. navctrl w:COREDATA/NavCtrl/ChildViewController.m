//
//  ChildViewController.m
//  NavCtrl
//
//  Created by Julio Reyes on 10/22/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "ChildViewController.h"
#import "DeviceWebViewController.h"
#import "qcdDemoCollectionViewCell.h"

@interface ChildViewController ()<UIGestureRecognizerDelegate, UIAlertViewDelegate>
@property qcdDAO *dataAccessObject;
@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;
@end

@implementation ChildViewController
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
    // self.clearsSelectionOnViewWillAppear = NO;

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(DeleteCell:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(250, 250)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    UINib *cellNib = [UINib nibWithNibName:@"qcdDemoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:CellIdentifier];
    
    [flowLayout release];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    [self.collectionView.collectionViewLayout invalidateLayout];
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.selectedCompany.CompanyProducts count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    qcdDemoCollectionViewCell *cell = (qcdDemoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                           forIndexPath:indexPath];

    // Configure the cell...
    NeueProduct *currentProducts = [self.selectedCompany.CompanyProducts objectAtIndex:indexPath.row];
    NSString *productName = currentProducts.ProductName;
    
    cell.cellName.text = productName;
    cell.cellImageView.image = [UIImage imageNamed:self.selectedCompany.CompanyImage];
    return cell;
}



#pragma mark - Remove COLLECTION
- (void)DeleteCell:(UILongPressGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really Delete?" message:@"Do you really want to remove this product?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Yes"];
        [alert show];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gr locationInView:self.collectionView]];
        selectedIndex = (int)indexPath.row;
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self removeCell];
    }
}

-(void)removeCell {
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:selectedIndex inSection:0];
    qcdDemoAppDelegate *appDelegate = APPDELEGATE;

    [self.collectionView performBatchUpdates:^{
        
        [appDelegate DeleteProductUsingCoreData:[self.selectedCompany.CompanyProducts
                                                 objectAtIndex:indexPath.row]];
        [self.selectedCompany.CompanyProducts removeObjectAtIndex:indexPath.row];
        
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
    } completion:^(BOOL finished) {
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - Table view delegate
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    DeviceWebViewController *detailViewController = [[DeviceWebViewController alloc] initWithNibName:@"DeviceWebViewController" bundle:nil];

    // Pass the selected object to the new view controller.
    NeueProduct *selectedProduct = [self.selectedCompany.CompanyProducts objectAtIndex:indexPath.row];
    detailViewController.title = selectedProduct.ProductName;
    
    detailViewController.deviceURL = selectedProduct.ProductReference;
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [detailViewController release];
}
 


@end
