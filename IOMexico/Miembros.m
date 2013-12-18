//
//  Miembros.m
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Miembros.h"
#import <Parse/Parse.h>
#import "Detalle_miembros.h"
@interface Miembros ()

@end

@implementation Miembros
@synthesize tableViewData;
@synthesize contenedor = _contenedor;
NSMutableArray *object_data;
NSString *dato;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    tableViewData = [[NSMutableArray alloc]init];
    tableIdViewData = [[NSMutableArray alloc]init];
    [self cargar_tabla];
}
-(void)cargar_tabla{
    [[self contenedor]setDelegate:self];
    [[self contenedor]setDataSource:self];
    [self.contenedor setBackgroundView:nil];
    [self.contenedor setBackgroundColor:[UIColor clearColor]];
    PFQuery *query = [PFQuery queryWithClassName:@"Perfil"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *nombre = [NSString stringWithFormat:@"%@", [object objectForKey:@"nombre"]];
                NSString *ides = object.objectId;
                [tableViewData addObject:nombre];
                [tableIdViewData addObject:ides];
            }
        } else {
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
    return [tableViewData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    cell.textLabel.text = [tableViewData objectAtIndex:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    dato = [tableIdViewData objectAtIndex:row];
    [self cambiarPantalla];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)regresar:(id)sender {
    [self dismissViewControllerAnimated:YES  completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void) cambiarPantalla{
    Detalle_miembros *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detalle_miembros"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.ides = dato;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
