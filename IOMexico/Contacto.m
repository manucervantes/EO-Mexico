//
//  Contacto.m
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 13/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Contacto.h"
#import <Parse/Parse.h>

@interface Contacto ()

@end

@implementation Contacto

@synthesize contact_asunto_txt,contact_mensaje_txt,contact_nombre_txt;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)regresar:(id)sender {
    [self dismissViewControllerAnimated:YES  completion:nil];
}

-(IBAction)enviar_contacto{
    
    
    NSString *nombre;
    NSString *mensaje;
    NSString *asunto;
    
    
    nombre = contact_nombre_txt.text;
    mensaje = contact_mensaje_txt.text;
    asunto = contact_asunto_txt.text;
    
    if (nombre.length == 0 || mensaje.length == 0 || asunto.length == 0 )
    {
        NSLog(@"vacio ");
        
        
    }
    else{
        
        PFUser *user = [PFUser currentUser];
        
        
        PFObject *contacto = [PFObject objectWithClassName:@"Contacto"];
        contacto[@"Nombre"] = nombre;
        contacto[@"Mensaje"] = mensaje;
        contacto[@"Asunto"] = asunto;
        [contacto setObject:user forKey:@"quien_contacta"];
        
        [contacto saveInBackground];
        
        
    }

 

}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    NSLog(@"asdasd");

    if(theTextField==contact_nombre_txt){
        [contact_asunto_txt becomeFirstResponder];
    }
    else if(theTextField==contact_asunto_txt){
        [contact_mensaje_txt becomeFirstResponder];
    }
    return YES;
}
- (IBAction)cerrart{
    [contact_mensaje_txt resignFirstResponder];
    [contact_asunto_txt resignFirstResponder];
    [contact_nombre_txt resignFirstResponder];

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
