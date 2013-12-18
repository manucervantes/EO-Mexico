//
//  Detalle_evento.m
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 13/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Detalle_evento.h"
#import <Parse/Parse.h>

@interface Detalle_evento ()

@end

@implementation Detalle_evento
@synthesize ides;
@synthesize texto,fecha_fin,fecha_inc,contenido;

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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Eventos"];
    [query whereKey:@"objectId" equalTo:ides];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                fecha_inc.text = [object objectForKey:@"Fecha_inicio"];
                fecha_fin.text = [object objectForKey:@"Fecha_termino"];
                texto.text =  [object objectForKey:@"Titulo"];
                contenido.text = [object objectForKey:@"Descripcion"];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)regresar:(id)sender {
    [self dismissViewControllerAnimated:YES  completion:nil];

}

@end
