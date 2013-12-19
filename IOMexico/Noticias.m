//
//  Noticias.m
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 12/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Noticias.h"
#import <Parse/Parse.h>
#import "Detalle_noticia.h"
@interface Noticias ()

@end

@implementation Noticias

@synthesize tableViewData;
@synthesize tableIdViewData;
@synthesize contenedor = _contenedor;
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
    [[self contenedor]setDelegate:self];
    [[self contenedor]setDataSource:self];
    [self.contenedor setBackgroundView
     :nil];
    [self.contenedor setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)viewDidAppear:(BOOL)animated{
   //
    
    /*tableIdViewData = [[NSMutableArray alloc]init];
    tableViewData = [[NSMutableArray alloc]init];
    [[self contenedor]setDelegate:self];
    [[self contenedor]setDataSource:self];
    [self.contenedor setBackgroundView:nil];
    [self.contenedor setBackgroundColor:[UIColor clearColor]];
    PFQuery *query = [PFQuery queryWithClassName:@"Noticias"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *resumen = [NSString stringWithFormat:@"%@", [object objectForKey:@"Titulo"]];
                NSString *ides = object.objectId;
                [tableViewData addObject:resumen];
                [tableIdViewData addObject:ides];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];*/
    
    NSLog(@"%@",tableViewData);
    NSLog(@"%@",tableIdViewData);
    
}

#pragma mark -
#pragma mark Table View data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%@",tableViewData);

    return [tableViewData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    cell.textLabel.text = [tableViewData objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textColor = [UIColor whiteColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    dato = [tableIdViewData objectAtIndex:row];
    NSLog(@"%@",dato);
    [self cambiarPantalla];
}
- (IBAction)regresar:(id)sender {
    [self dismissViewControllerAnimated:YES  completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void) cambiarPantalla{
    Detalle_noticia *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"detalle_noticias"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.ides = dato;
    
    [self presentViewController:controller animated:YES completion:nil];
}



@end
