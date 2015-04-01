//
//  ViewController.m
//  SQLLite_TEST
//
//  Created by Julio Reyes on 03/12/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *arrayOfPesron;
    sqlite3 *personDB;
    NSString *dbPathString;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayOfPesron = [[NSMutableArray alloc] init];
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    [self createOrOpenDB];
    [self displayPerson];
}

-(void)createOrOpenDB
{
    char *error;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    dbPathString = [docPath stringByAppendingPathComponent:@"Person.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:dbPathString])
    {
        const char *dbPath = [dbPathString UTF8String];
        
        //cretae database
        if (sqlite3_open(dbPath, &personDB)== SQLITE_OK)
        {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PERSONS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
            if(sqlite3_exec(personDB, sql_stmt, NULL, NULL, &error) == SQLITE_OK)
                //execute the sql statement
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Create" message:@"Create table" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [alert show];
            }
            sqlite3_close(personDB);

        }
        else
        {
            NSLog(@"Unable to open db");
        }
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayOfPesron count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    Person *aPeraon = [arrayOfPesron objectAtIndex:indexPath.row];
    cell.textLabel.text = aPeraon.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",aPeraon.age];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPersonButton:(id)sender
{
    char *error;
    if(sqlite3_open([dbPathString UTF8String], &personDB) == SQLITE_OK)
    {
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PERSONS (NAME,AGE) VALUES ('%s','%d')",[self.nameField.text UTF8String],[self.ageField.text intValue]];
        const char *insert_stmt = [insertStmt UTF8String];
        NSLog(@"Add Person button click..");
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
        {
            NSLog(@"Person added to DB");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add person Complete" message:@"Person added to DB" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
//            Person *person = [[Person alloc] init];
//            [person setName:self.nameField.text];
//            [person setAge:[self.ageField.text intValue]];
//            [arrayOfPesron addObject:person];
        }
        sqlite3_close(personDB);
    }
    [self displayPerson];

}

- (IBAction)deletePersonButton:(id)sender
{
    UIButton *btn  = sender;
    if([[self myTableView] isEditing])
    {
        [btn setTitle:@"Delete" forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:@"Done" forState:UIControlStateNormal];
    }

    [[self myTableView]setEditing:!self.myTableView.editing animated:YES];
}

-(void)deleteData:(NSString *)deleteQuery
{
    char *error;
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK)
    {
        NSLog(@"Person Deleted");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Person Deleted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Person *p = [arrayOfPesron objectAtIndex:indexPath.row];
        [self deleteData:[NSString stringWithFormat:@"DELETE FROM PERSONS WHERE NAME IS '%s'", [p.name UTF8String]]];
        [arrayOfPesron removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)displayPerson
{
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK)
    {
        [arrayOfPesron removeAllObjects];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM PERSONS"];
        const char *query_sql = [querySQL UTF8String];
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *ageString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                Person *person = [[Person alloc]init];
                [person setName:name];
                [person setAge:[ageString intValue]];
                [arrayOfPesron addObject:person];
                
            }
        }
    }
    [[self myTableView]reloadData];
}
@end
