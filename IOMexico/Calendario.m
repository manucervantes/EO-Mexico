//
//  Calendario.m
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Calendario.h"
#import <Parse/Parse.h>
#import "Detalle_evento.h"

@interface Calendario ()

@end

@implementation Calendario
@synthesize tableViewData;
@synthesize tableIdViewData;
@synthesize contenedor = _contenedor;

int flag = 0, flag2 = 0;
NSMutableArray *object_data;
NSString *dato;
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
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Eventos"];
    // [query selectKeys:@[@"nombre",@"locations"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            
            for (PFObject *object in objects) {
                NSLog(@"%@", [object objectForKey:@"Titulo"]);
                
                NSString *resumen = [NSString stringWithFormat:@"%@", [object objectForKey:@"Titulo"]];
                NSString *ides = object.objectId;
                
                [tableViewData addObject:resumen];
                [tableIdViewData addObject:ides];
                
                
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
    NSLog(@"count %lu",(unsigned long)[tableViewData count]);
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
    
        dato = [tableIdViewData objectAtIndex:row];
          [self cambiarPantalla];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)regresar:(id)sender {
    [self dismissViewControllerAnimated:YES  completion:nil];
}



- (void) cambiarPantalla{
    
    Detalle_evento *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detalle_eventos"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.ides = dato;
    
    [self presentViewController:controller animated:YES completion:nil];
    

}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
