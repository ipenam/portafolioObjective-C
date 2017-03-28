//
//  ItemsTableViewController.m
//  PortafolioObjective-C
//
//  Created by Ivan Peña on 22/03/17.
//  Copyright © 2017 ipenam. All rights reserved.
//

#import "ItemsTableViewController.h"
#import "ItemStore.h"
#import "Item.h"

#import "DetailViewController.h"

@interface ItemsTableViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemsTableViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = barItem;
        navItem.leftBarButtonItem = self.editButtonItem;

    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    //UIView *header = self.headerView;
    //[self.tableView setTableHeaderView:header];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[ItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // UITableViewCell *cell =
   // [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
   //                        reuseIdentifier:@"UITableViewCell"];
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                    forIndexPath:indexPath];

    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return cell;
}

-(void)  tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSArray *items = [[ItemStore sharedStore] allItems];
        Item *item = [items objectAtIndex:indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)  tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                     toIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *selectedItem = [items objectAtIndex:indexPath.row];
    
    detailViewController.item = selectedItem;
    
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
}

- (IBAction)addNewItem:(id)sender
{
    
    Item *newItem = [[ItemStore sharedStore] createItem];
    
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
    
}
/*
- (IBAction)toggleEditingMode:(id)sender
{
    
    // If you are currently in editing mode...
    if (self.isEditing) {
        // Change text of button to inform user of state
        [sender setTitle:@"Editar" forState:UIControlStateNormal];
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change text of button to inform user of state
        [sender setTitle:@"Hecho" forState:UIControlStateNormal];
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
    
}

- (UIView *)headerView
{
    UIView * view;
    // If you have not loaded the headerView yet...
    if (!_headerView) {
        // Load HeaderView.xib
        view = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil] objectAtIndex:0];
    }
    return view;
}*/

@end
