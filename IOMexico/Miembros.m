//
//  Miembros.m
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Miembros.h"
#import <Parse/Parse.h>
@interface Miembros ()

@end

@implementation Miembros
@synthesize tableViewData;
@synthesize contenedor = _contenedor;
NSMutableArray *object_data;

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
    
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    tableViewData = [[NSMutableArray alloc]init];

    [self cargar_tabla];
}
-(void)cargar_tabla{
    
    [[self contenedor]setDelegate:self];
    [[self contenedor]setDataSource:self];
    [self.contenedor setBackgroundView:nil];
    [self.contenedor setBackgroundColor:[UIColor clearColor]];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Perfil"];
    // [query selectKeys:@[@"nombre",@"locations"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            
            for (PFObject *object in objects) {
                //  NSLog(@"%@", [object
                
                NSString *nombre = [NSString stringWithFormat:@"%@", [object objectForKey:@"nombre"]];
                
                [tableViewData addObject:nombre];
       
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}



#pragma mark -
#pragma mark Table View data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count %d",[tableViewData count]);
    return [tableViewData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell  = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    cell.textLabel.text = [tableViewData objectAtIndex:indexPath.row];
    NSLog(@"cell %@",cell);
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    // NSString *newText = [tableViewData objectAtIndex:row];
    //if (row==0) {
    //}
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)regresar:(id)sender {
    [self dismissViewControllerAnimated:YES  completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
