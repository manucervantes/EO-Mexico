//
//  Principal.m
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Principal.h"
#import "Noticias.h"
#import "Calendario.h"
#import "Miembros.h"
#import <Parse/Parse.h>
@interface Principal ()

@end

@implementation Principal
@synthesize tableViewData_noticias,tableIdViewData_noticias;
@synthesize tableIdViewData_eventos,tableViewData_eventos;
@synthesize tableIdViewData_miembros,tableViewData_miembros;
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
    NSLog(@"asd");
}

-(void)viewDidAppear:(BOOL)animated{
    [self cargar_noticias];
    [self cargar_eventos];
    [self cargar_miembros];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)cargar_noticias{
    tableIdViewData_noticias = [[NSMutableArray alloc]init];
    tableViewData_noticias = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Noticias"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *resumen = [NSString stringWithFormat:@"%@", [object objectForKey:@"Titulo"]];
                NSString *ides = object.objectId;
                [tableViewData_noticias addObject:resumen];
                [tableIdViewData_noticias addObject:ides];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}
- (IBAction)not:(id)sender {

    Noticias *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"noticias"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    controller.tableViewData = tableViewData_noticias;
    controller.tableIdViewData = tableIdViewData_noticias;
    
    [self presentViewController:controller animated:YES completion:nil];

}


-(void)cargar_eventos{
    tableIdViewData_eventos = [[NSMutableArray alloc]init];
    tableViewData_eventos = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Eventos"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *resumen = [NSString stringWithFormat:@"%@", [object objectForKey:@"Titulo"]];
                NSString *ides = object.objectId;
                [tableViewData_eventos addObject:resumen];
                [tableIdViewData_eventos addObject:ides];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}
- (IBAction)even:(id)sender {
    
    Calendario *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"eventos"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    controller.tableViewData = tableViewData_eventos;
    controller.tableIdViewData = tableIdViewData_eventos;
    
    [self presentViewController:controller animated:YES completion:nil];
    
}
-(void)cargar_miembros{
    tableIdViewData_miembros = [[NSMutableArray alloc]init];
    tableViewData_miembros = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Perfil"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *nombre = [NSString stringWithFormat:@"%@", [object objectForKey:@"nombre"]];
                NSString *ides = object.objectId;
                [tableViewData_miembros addObject:nombre];
                [tableIdViewData_miembros addObject:ides];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
}
- (IBAction)miem:(id)sender {
    
    Miembros *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"miembros"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    controller.tableViewData = tableViewData_miembros;
    NSLog(@"%@",tableIdViewData_miembros);
    controller.tableIdViewData = tableIdViewData_miembros;
    
    [self presentViewController:controller animated:YES completion:nil];
    
}
@end
